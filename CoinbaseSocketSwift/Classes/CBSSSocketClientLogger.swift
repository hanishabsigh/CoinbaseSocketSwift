//
//  CBSSSocketClientLogger.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 11/1/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

public protocol CBSSSocketClientLogger: class {
    func logCBSSSocketDidConnect(socket: CBSSSocketClient)
    func logCBSSSocketDidDisconnect(socket: CBSSSocketClient, error: Error?)
    func logCBSSSocketDidReceiveMessage(socket: CBSSSocketClient, text: String)
    func logCBSSSocketResponseParsingFailure(socket: CBSSSocketClient, message: String)
    func logCBSSSocketAuthenticationBuilderError(socket: CBSSSocketClient, message: String)
    func logCBSSSocketGeneralError(socket: CBSSSocketClient, message: String)
}

public class CBSSSocketClientDefaultLogger: CBSSSocketClientLogger {
    
    public init() {
        
    }
    
    public func logCBSSSocketDidConnect(socket: CBSSSocketClient) {
        print("--")
        print("-- CBSSSocketClient CONNECT \(socket.baseURLString ?? "")")
    }
    
    public func logCBSSSocketDidDisconnect(socket: CBSSSocketClient, error: Error?) {
        print("--")
        print("-- CBSSSocketClient DISCONNECT \(socket.baseURLString ?? "")")
    }
    
    public func logCBSSSocketDidReceiveMessage(socket: CBSSSocketClient, text: String) {
        print("--")
        guard let data = text.data(using: .utf8) else { return }
        guard let json = data.json else { return }
        let type = json["type"] as? String ?? ""
        print("-- CBSSSocketClient MESSAGE TYPE:\(type.uppercased())")
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]) else { return }
        guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else { return }
        print(jsonString)
    }
    
    public func logCBSSSocketResponseParsingFailure(socket: CBSSSocketClient, message: String) {
        print("----CBSSSocketClient Parsing Error----")
        print("\n")
        print("Failure to parse json key: \(message)")
        print("\n")
        print("----CBSSSocketClient Parsing Error----")
    }
    
    public func logCBSSSocketAuthenticationBuilderError(socket: CBSSSocketClient, message: String) {
        print("----CBSSSocketClient Authentication Error----")
        print("\n")
        print(message)
        print("\n")
        print("----CBSSSocketClient Authentication Error----")
    }
    
    public func logCBSSSocketGeneralError(socket: CBSSSocketClient, message: String) {
        print("----CBSSSocketClient General Error----")
        print("\n")
        print(message)
        print("\n")
        print("----CBSSSocketClient General Error----")
    }
}
