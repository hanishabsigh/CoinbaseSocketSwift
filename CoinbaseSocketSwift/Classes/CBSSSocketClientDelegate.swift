//
//  CBSSSocketClientDelegate.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 11/5/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

@objc public protocol CBSSSocketClientDelegate: class {
    @objc optional func cbssSocketDidConnect(socket: CBSSSocketClient)
    @objc optional func cbssSocketDidDisconnect(socket: CBSSSocketClient, error: Error?)
    
    @objc optional func cbssSocketClientOnErrorMessage(socket: CBSSSocketClient, error: CBSSErrorMessage)
    
    @objc optional func cbssSocketClientOnSubscriptions(socket: CBSSSocketClient, subscriptions: CBSSSubscriptions)
    
    @objc optional func cbssSocketClientOnHeartbeat(socket: CBSSSocketClient, heartbeat: CBSSHeartbeat)
    
    @objc optional func cbssSocketClientOnTicker(socket: CBSSSocketClient, ticker: CBSSTicker)
    
    @objc optional func cbssSocketClientOnSnapshot(socket: CBSSSocketClient, snapshot: CBSSSnapshot)
    @objc optional func cbssSocketClientOnUpdate(socket: CBSSSocketClient, update: CBSSUpdate)
    
    @objc optional func cbssSocketClientOnReceived(socket: CBSSSocketClient, received: CBSSReceived)
    @objc optional func cbssSocketClientOnOpen(socket: CBSSSocketClient, open: CBSSOpen)
    @objc optional func cbssSocketClientOnDone(socket: CBSSSocketClient, done: CBSSDone)
    @objc optional func cbssSocketClientOnMatch(socket: CBSSSocketClient, match: CBSSMatch)
    @objc optional func cbssSocketClientOnChange(socket: CBSSSocketClient, change: CBSSChange)
    @objc optional func cbssSocketClientOnMarginProfileUpdate(socket: CBSSSocketClient, marginProfileUpdate: CBSSMarginProfileUpdate)
    @objc optional func cbssSocketClientOnActivate(socket: CBSSSocketClient, activate: CBSSActivate)
}
