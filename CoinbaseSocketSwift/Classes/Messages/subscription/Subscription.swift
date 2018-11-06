//
//  Subscription.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class Subscription {
    
    public let channel:Channel
    public let productIds:[ProductId]
    
    public init(json: [String: Any]) throws {
        
        guard let channel = Channel(rawValue: json["name"] as? String ?? "") else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("subscription_name")
        }
        
        guard let productIdStrings = json["product_ids"] as? [String] else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("subscription_product_ids")
        }
        
        var productIdObjects = [ProductId]()
        for productIdString in productIdStrings {
            guard let productId = ProductId(rawValue: productIdString) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("subscription_product_id")
            }
            
            productIdObjects.append(productId)
        }
        
        self.channel = channel
        self.productIds = productIdObjects
    }
}
