//
//  ProductSequenceTimeMessage.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class ProductSequenceTimeMessage: ProductMessage {
    
    public let sequence: Int
    public let time: Date?
    
    public required init(json: [String: Any]) throws {
        guard let sequence = json["sequence"] as? NSNumber else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("sequence")
        }
        
        let time = (json["time"] as? String)?.dateFromISO8601
        
        self.sequence = sequence.intValue
        self.time = time
        
        try super.init(json: json)
    }
}
