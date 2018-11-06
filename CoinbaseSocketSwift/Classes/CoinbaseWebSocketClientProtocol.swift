//
//  CoinbaseWebSocketClientProtocol.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/31/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

public protocol CoinbaseWebSocketClientDelegate: class {
    func websocketDidConnect(socket: CoinbaseWebSocketClient)
    func websocketDidDisconnect(socket: CoinbaseWebSocketClient, error: Error?)
    func websocketDidReceiveMessage(socket: CoinbaseWebSocketClient, text: String)
}

public protocol CoinbaseWebSocketClient: class {
    
    var baseURLString: String { get }
    
    var delegate: CoinbaseWebSocketClientDelegate? { get set}
    
    func connect()
    func disconnect()
    
    var isConnected: Bool { get }
    
    func write(string: String)
}
