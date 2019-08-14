//
//  CoinbaseSocketClient.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/26/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

@objc public class CoinbaseSocketClient: NSObject {
    
    public static let legacyAPIURLString = "wss://ws-feed.gdax.com"
    public static let legacySandboxAPIURLString = "wss://ws-feed-public.sandbox.gdax.com"
    
    public static let baseProAPIURLString = "wss://ws-feed.pro.coinbase.com"
    public static let baseProSandboxAPIURLString = "wss://ws-feed-public.sandbox.pro.coinbase.com"
    
    public static let basePrimeAPIURLString = "wss://ws-feed.prime.coinbase.com"
    public static let basePrimeSandboxAPIURLString = "wss://ws-feed-public.sandbox.prime.coinbase.com"
    
    internal let apiKey: String?
    internal let secret64: String?
    internal let passphrase: String?
    
    public weak var delegate: CoinbaseSocketClientDelegate?
    public var webSocket: CoinbaseWebSocketClient? {
        didSet(oldSocket) {
            webSocket?.delegate = self
            url = webSocket?.url
        }
    }
    public var logger: CoinbaseSocketClientLogger?
    
    private(set) var url: URL?
    private(set) var currentSubscriptions: [Subscription]?
    
    public var isConnected: Bool {
        guard let connected = self.webSocket?.isConnected else {
            return false
        }
        return connected
    }
    
    public init(apiKey: String? = nil,
                secret64: String? = nil,
                passphrase: String? = nil) {
        self.apiKey = apiKey
        self.secret64 = secret64
        self.passphrase = passphrase
    }
    
    public func connect() {
        webSocket?.connect()
    }
    
    public func disconnect() {
        webSocket?.disconnect()
    }
    
    public func subscribe(channels: [Channel], productIds: [String]) {
        let subscribe = SubscribeMessage(channels: channels, productIds: productIds)
        authenticateAndWrite(json: subscribe.asJSON())
    }
    
    public func unsubscribe(channels: [Channel], productIds: [String]) {
        let unsubscribe = UnsubscribeMessage(channels: channels, productIds: productIds)
        authenticateAndWrite(json: unsubscribe.asJSON())
    }
    
    private func authenticate(json: [String: Any]) -> [String: Any] {
        var json = json
        do {
            try CoinbaseSocketAuthenticator.authenticate(jsonObject: &json, apiKey: apiKey, secret64: secret64, passphrase: passphrase)
        } catch CoinbaseSocketSwiftError.authenticationBuilderError(let message) {
            logger?.logCoinbaseSocketAuthenticationBuilderError(socket: self, message: message)
        } catch { }
        return json
    }
    
    private func authenticateAndWrite(json: [String: Any]) {
        let authenticatedJson = authenticate(json: json)
        self.write(json: authenticatedJson)
    }
    
    private func write(json: [String: Any]) {
        guard let jsonData = json.jsonData else { return }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        webSocket?.write(string: jsonString, completionHandler: { (error) in
            self.logger?.logCoinbaseSocketWriteFailure(socket: self, error: error)
        })
    }
    
    private func processIncomingMessage(text: String) {
        guard let json = convertTextToJson(text: text) else {
            self.logger?.logCoinbaseSocketGeneralError(socket: self, message: "Failed to create JSON object from incoming WebSocket message.")
            return
        }
        do {
            try self.notifyDelegatesOfIncomingJSONMessage(json: json)
        } catch CoinbaseSocketSwiftError.responseParsingFailure(let message) {
            self.logger?.logCoinbaseSocketResponseParsingFailure(socket: self, message: message)
        } catch { }
    }
    
    private func convertTextToJson(text:String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        guard let json = data.json else {
            return nil
        }
        return json
    }
    
    private func notifyDelegatesOfIncomingJSONMessage(json: [String: Any]) throws {
        guard let type = json["type"] as? String else { return }
        guard let messageType = MessageType(rawValue: type) else { return }
        switch messageType {
        case .error:
            let error = try ErrorMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnErrorMessage?(socket: self, error: error)
            }
            break
        case .subscriptions:
            let subscriptions = try SubscriptionsMessage(json: json)
            self.currentSubscriptions = subscriptions.channels
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnSubscriptions?(socket: self, subscriptions: subscriptions)
            }
            break
        case .heartbeat:
            let heartbeat = try HeartbeatMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnHeartbeat?(socket: self, heartbeat: heartbeat)
            }
            break
        case .ticker:
            let ticker = try TickerMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnTicker?(socket: self, ticker: ticker)
            }
            break
        case .snapshot:
            let snapshot = try SnapshotMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnSnapshot?(socket: self, snapshot: snapshot)
            }
            break
        case .update:
            let update = try UpdateMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnUpdate?(socket: self, update: update)
            }
            break
        case .received:
            let received = try ReceivedMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnReceived?(socket: self, received: received)
            }
            break
        case .open:
            let open = try OpenMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnOpen?(socket: self, open: open)
            }
            break
        case .done:
            let done = try DoneMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnDone?(socket: self, done: done)
            }
            break
        case .match:
            let match = try MatchMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnMatch?(socket: self, match: match)
            }
            break
        case .change:
            let change = try ChangeMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnChange?(socket: self, change: change)
            }
            break
        case .marginProfileUpdate:
            let marginProfileUpdate = try MarginProfileUpdateMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnMarginProfileUpdate?(socket: self, marginProfileUpdate: marginProfileUpdate)
            }
            break
        case .activate:
            let activate = try ActivateMessage(json: json)
            DispatchQueue.main.async {
                self.delegate?.coinbaseSocketClientOnActivate?(socket: self, activate: activate)
            }
            break
        case .unknown:
            fallthrough
        default:
            print("CoinbaseSocketClient received unknown json message with format \(json)")
            break
        }
    }
}

extension CoinbaseSocketClient: CoinbaseWebSocketClientDelegate {
    
    public func websocketDidConnect(socket: CoinbaseWebSocketClient) {
        self.logger?.logCoinbaseSocketDidConnect(socket: self)
        self.delegate?.coinbaseSocketDidConnect?(socket: self)
    }
    
    public func websocketDidDisconnect(socket: CoinbaseWebSocketClient, error: Error?) {
        self.logger?.logCoinbaseSocketDidDisconnect(socket: self, error: error)
        self.currentSubscriptions = nil
        self.delegate?.coinbaseSocketDidDisconnect?(socket: self, error: error)
    }
    
    public func websocketDidReceiveMessage(socket: CoinbaseWebSocketClient, text: String) {
        self.logger?.logCoinbaseSocketDidReceiveMessage(socket: self, text: text)
        self.processIncomingMessage(text: text)
    }
}
