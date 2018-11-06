//
//  CoinbaseSocketClientDelegate.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 11/5/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

@objc public protocol CoinbaseSocketClientDelegate: class {
    @objc optional func coinbaseSocketDidConnect(socket: CoinbaseSocketClient)
    @objc optional func coinbaseSocketDidDisconnect(socket: CoinbaseSocketClient, error: Error?)
    
    @objc optional func coinbaseSocketClientOnErrorMessage(socket: CoinbaseSocketClient, error: ErrorMessage)
    
    @objc optional func coinbaseSocketClientOnSubscriptions(socket: CoinbaseSocketClient, subscriptions: SubscriptionsMessage)
    
    @objc optional func coinbaseSocketClientOnHeartbeat(socket: CoinbaseSocketClient, heartbeat: HeartbeatMessage)
    
    @objc optional func coinbaseSocketClientOnTicker(socket: CoinbaseSocketClient, ticker: TickerMessage)
    
    @objc optional func coinbaseSocketClientOnSnapshot(socket: CoinbaseSocketClient, snapshot: SnapshotMessage)
    @objc optional func coinbaseSocketClientOnUpdate(socket: CoinbaseSocketClient, update: UpdateMessage)
    
    @objc optional func coinbaseSocketClientOnReceived(socket: CoinbaseSocketClient, received: ReceivedMessage)
    @objc optional func coinbaseSocketClientOnOpen(socket: CoinbaseSocketClient, open: OpenMessage)
    @objc optional func coinbaseSocketClientOnDone(socket: CoinbaseSocketClient, done: DoneMessage)
    @objc optional func coinbaseSocketClientOnMatch(socket: CoinbaseSocketClient, match: MatchMessage)
    @objc optional func coinbaseSocketClientOnChange(socket: CoinbaseSocketClient, change: ChangeMessage)
    @objc optional func coinbaseSocketClientOnMarginProfileUpdate(socket: CoinbaseSocketClient, marginProfileUpdate: MarginProfileUpdateMessage)
    @objc optional func coinbaseSocketClientOnActivate(socket: CoinbaseSocketClient, activate: ActivateMessage)
}
