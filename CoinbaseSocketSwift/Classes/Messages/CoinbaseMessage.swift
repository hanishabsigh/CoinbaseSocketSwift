//
//  CoinbaseMessage.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class CoinbaseMessage: NSObject, JSONInitializable {
    
    public let type: MessageType

    public required init(json: [String: Any]) throws {

        guard let type = MessageType(rawValue: json["type"] as? String ?? "") else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("type")
        }
        
        self.type = type
    }
}
