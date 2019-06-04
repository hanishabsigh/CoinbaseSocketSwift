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
    public let productIds:[String]
    
    public init(json: [String: Any]) throws {
        
        guard let channel = Channel(rawValue: json["name"] as? String ?? "") else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("subscription_name")
        }
        
        guard let productIds = json["product_ids"] as? [String] else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("subscription_product_ids")
        }
        
        self.channel = channel
        self.productIds = productIds
    }
}
