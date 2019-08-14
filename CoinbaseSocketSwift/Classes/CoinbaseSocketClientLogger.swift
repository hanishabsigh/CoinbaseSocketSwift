//
//  CoinbaseSocketClientLogger.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 11/1/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

public protocol CoinbaseSocketClientLogger: class {
    func logCoinbaseSocketDidConnect(socket: CoinbaseSocketClient)
    func logCoinbaseSocketDidDisconnect(socket: CoinbaseSocketClient, error: Error?)
    func logCoinbaseSocketDidReceiveMessage(socket: CoinbaseSocketClient, text: String)
    func logCoinbaseSocketResponseParsingFailure(socket: CoinbaseSocketClient, message: String)
    func logCoinbaseSocketWriteFailure(socket: CoinbaseSocketClient, error: Error?)
    func logCoinbaseSocketAuthenticationBuilderError(socket: CoinbaseSocketClient, message: String)
    func logCoinbaseSocketGeneralError(socket: CoinbaseSocketClient, message: String)
}

public class CoinbaseSocketClientDefaultLogger: CoinbaseSocketClientLogger {
    
    public init() {
        
    }
    
    public func logCoinbaseSocketDidConnect(socket: CoinbaseSocketClient) {
        print("-- CoinbaseSocketClient CONNECT \(socket.url?.absoluteString ?? "")")
        print("\n")
    }
    
    public func logCoinbaseSocketDidDisconnect(socket: CoinbaseSocketClient, error: Error?) {
        print("-- CoinbaseSocketClient DISCONNECT \(socket.url?.absoluteString ?? "")")
        print(error?.localizedDescription ?? "Error")
        print("\n")
    }
    
    public func logCoinbaseSocketDidReceiveMessage(socket: CoinbaseSocketClient, text: String) {
        guard let data = text.data(using: .utf8) else { return }
        guard let json = data.json else { return }
        let type = json["type"] as? String ?? ""
        print("-- CoinbaseSocketClient MESSAGE TYPE:\(type.uppercased())")
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]) else { return }
        guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else { return }
        print(jsonString)
        print("\n")
    }
    
    public func logCoinbaseSocketResponseParsingFailure(socket: CoinbaseSocketClient, message: String) {
        print("----CoinbaseSocketClient Parsing Error----")
        print("Failure to parse json key: \(message)")
        print("\n")
    }
    
    public func logCoinbaseSocketWriteFailure(socket: CoinbaseSocketClient, error: Error?) {
        print("-- CoinbaseSocketClient Write Failure \(socket.url?.absoluteString ?? "")")
        print(error?.localizedDescription ?? "Error")
        print("\n")
    }
    
    public func logCoinbaseSocketAuthenticationBuilderError(socket: CoinbaseSocketClient, message: String) {
        print("----CoinbaseSocketClient Authentication Error----")
        print(message)
        print("\n")
    }
    
    public func logCoinbaseSocketGeneralError(socket: CoinbaseSocketClient, message: String) {
        print("----CoinbaseSocketClient General Error----")
        print(message)
        print("\n")
    }
}
