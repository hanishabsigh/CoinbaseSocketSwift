//
//  ExampleWebSocketClient.swift
//  CoinbaseSocketSwift_Example
//
//  Created by Hani Shabsigh on 11/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import CoinbaseSocketSwift
import Starscream

public class ExampleWebSocketClient: CoinbaseWebSocketClient {
    
    fileprivate let socket: WebSocket
    
    public let url: URL
    
    public required init(url: URL) {
        self.url = url
        socket = WebSocket(url: url)
        socket.delegate = self
    }
    
    public weak var delegate: CoinbaseWebSocketClientDelegate?
    
    public func connect() {
        socket.connect()
    }
    
    public func disconnect() {
        socket.disconnect()
    }
    
    public var isConnected: Bool {
        return self.socket.isConnected
    }
    
    public func write(string: String, completionHandler: @escaping (Error?) -> Void) {
        socket.write(string: string)
    }
}

extension ExampleWebSocketClient: WebSocketDelegate {
    
    public func websocketDidConnect(socket: WebSocketClient) {
        self.delegate?.websocketDidConnect(socket: self)
    }
    
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        self.delegate?.websocketDidDisconnect(socket: self, error: error)
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        self.delegate?.websocketDidReceiveMessage(socket: self, text: text)
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}
