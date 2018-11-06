//
//  UpdateMessage.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

open class UpdateMessage: ProductMessage {
    
    public let changes: [UpdateChange]
    
    public required init(json: [String: Any]) throws {
        
        guard let changes = json["changes"] as? [[String]] else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("changes")
        }
        
        var changeObjects = [UpdateChange]()
        for change in changes {
            guard let side = OrderSide(rawValue: change[0]) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("change_side")
            }
            
            guard let price = Double(change[1]) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("change_price")
            }
            
            guard let size = Double(change[2]) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("change_size")
            }
            
            changeObjects.append(UpdateChange(side: side, price: price, size: size))
        }
        
        self.changes = changeObjects
        
        try super.init(json: json)
    }
}
