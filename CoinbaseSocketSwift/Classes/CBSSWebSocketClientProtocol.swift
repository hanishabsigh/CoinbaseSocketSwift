//
//  CBSSWebSocketClientProtocol.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/31/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

public protocol CBSSWebSocketClientDelegate: class {
    func websocketDidConnect(socket: CBSSWebSocketClient)
    func websocketDidDisconnect(socket: CBSSWebSocketClient, error: Error?)
    func websocketDidReceiveMessage(socket: CBSSWebSocketClient, text: String)
}

public protocol CBSSWebSocketClient: class {
    
    var baseURLString: String { get }
    
    var delegate: CBSSWebSocketClientDelegate? { get set}
    
    func connect()
    func disconnect()
    
    var isConnected: Bool { get }
    
    func write(string: String)
}
