//
//  CBSSSocketClient.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/26/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

@objc public class CBSSSocketClient: NSObject {
    
    public static let legacyAPIURLString = "wss://ws-feed.gdax.com"
    public static let legacySandboxAPIURLString = "wss://ws-feed-public.sandbox.gdax.com"
    
    public static let baseProAPIURLString = "wss://ws-feed.pro.coinbase.com"
    public static let baseProSandboxAPIURLString = "wss://ws-feed-public.sandbox.pro.coinbase.com"
    
    public static let basePrimeAPIURLString = "wss://ws-feed.prime.coinbase.com"
    public static let basePrimeSandboxAPIURLString = "wss://ws-feed-public.sandbox.prime.coinbase.com"
    
    internal let apiKey: String?
    internal let secret64: String?
    internal let passphrase: String?
    
    public weak var delegate: CBSSSocketClientDelegate?
    public var webSocket: CBSSWebSocketClient? {
        didSet(oldSocket) {
            webSocket?.delegate = self
            baseURLString = webSocket?.baseURLString
        }
    }
    public var logger: CBSSSocketClientLogger?
    
    private(set) var baseURLString: String?
    private(set) var currentSubscriptions: [CBSSSubscription]?
    
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
    
    public func subscribe(channels: [CBSSChannel], productIds: [CBSSProductId]) {
        let subscribe = CBSSSubscribe(channels: channels, productIds: productIds)
        authenticateAndWrite(json: subscribe.asJSON())
    }
    
    public func unsubscribe(channels: [CBSSChannel], productIds: [CBSSProductId]) {
        let unsubscribe = CBSSUnsubscribe(channels: channels, productIds: productIds)
        authenticateAndWrite(json: unsubscribe.asJSON())
    }
    
    private func authenticate(json: [String: Any]) -> [String: Any] {
        var json = json
        do {
            try CBSSSocketAuthenticator.authenticate(jsonObject: &json, apiKey: apiKey, secret64: secret64, passphrase: passphrase)
        } catch CBSSError.authenticationBuilderError(let message) {
            logger?.logCBSSSocketAuthenticationBuilderError(socket: self, message: message)
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
        webSocket?.write(string: jsonString)
    }
    
    private func processIncomingMessage(text: String) {
        guard let json = convertTextToJson(text: text) else {
            self.logger?.logCBSSSocketGeneralError(socket: self, message: "Failed to create JSON object from incoming WebSocket message.")
            return
        }
        do {
            try self.notifyDelegatesOfIncomingJSONMessage(json: json)
        } catch CBSSError.responseParsingFailure(let message) {
            self.logger?.logCBSSSocketResponseParsingFailure(socket: self, message: message)
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
        guard let cbssType = CBSSType(rawValue: type) else { return }
        switch cbssType {
        case .error:
            let error = try CBSSErrorMessage(json: json)
            self.delegate?.cbssSocketClientOnErrorMessage?(socket: self, error: error)
            break
        case .subscriptions:
            let subscriptions = try CBSSSubscriptions(json: json)
            self.currentSubscriptions = subscriptions.channels
            self.delegate?.cbssSocketClientOnSubscriptions?(socket: self, subscriptions: subscriptions)
            break
        case .heartbeat:
            let heartbeat = try CBSSHeartbeat(json: json)
            self.delegate?.cbssSocketClientOnHeartbeat?(socket: self, heartbeat: heartbeat)
            break
        case .ticker:
            let ticker = try CBSSTicker(json: json)
            self.delegate?.cbssSocketClientOnTicker?(socket: self, ticker: ticker)
            break
        case .snapshot:
            let snapshot = try CBSSSnapshot(json: json)
            self.delegate?.cbssSocketClientOnSnapshot?(socket: self, snapshot: snapshot)
            break
        case .update:
            let update = try CBSSUpdate(json: json)
            self.delegate?.cbssSocketClientOnUpdate?(socket: self, update: update)
            break
        case .received:
            let received = try CBSSReceived(json: json)
            self.delegate?.cbssSocketClientOnReceived?(socket: self, received: received)
            break
        case .open:
            let open = try CBSSOpen(json: json)
            self.delegate?.cbssSocketClientOnOpen?(socket: self, open: open)
            break
        case .done:
            let done = try CBSSDone(json: json)
            self.delegate?.cbssSocketClientOnDone?(socket: self, done: done)
            break
        case .match:
            let match = try CBSSMatch(json: json)
            self.delegate?.cbssSocketClientOnMatch?(socket: self, match: match)
            break
        case .change:
            let change = try CBSSChange(json: json)
            self.delegate?.cbssSocketClientOnChange?(socket: self, change: change)
            break
        case .marginProfileUpdate:
            let marginProfileUpdate = try CBSSMarginProfileUpdate(json: json)
            self.delegate?.cbssSocketClientOnMarginProfileUpdate?(socket: self, marginProfileUpdate: marginProfileUpdate)
            break
        case .activate:
            let activate = try CBSSActivate(json: json)
            self.delegate?.cbssSocketClientOnActivate?(socket: self, activate: activate)
            break
        case .unknown:
            fallthrough
        default:
            print("CBSSSocketClient received unknown json message with format \(json)")
            break
        }
    }
}

extension CBSSSocketClient: CBSSWebSocketClientDelegate {
    
    public func websocketDidConnect(socket: CBSSWebSocketClient) {
        self.logger?.logCBSSSocketDidConnect(socket: self)
        self.delegate?.cbssSocketDidConnect?(socket: self)
    }
    
    public func websocketDidDisconnect(socket: CBSSWebSocketClient, error: Error?) {
        self.logger?.logCBSSSocketDidDisconnect(socket: self, error: error)
        self.currentSubscriptions = nil
        self.delegate?.cbssSocketDidDisconnect?(socket: self, error: error)
    }
    
    public func websocketDidReceiveMessage(socket: CBSSWebSocketClient, text: String) {
        self.logger?.logCBSSSocketDidReceiveMessage(socket: self, text: text)
        self.processIncomingMessage(text: text)
    }
}
