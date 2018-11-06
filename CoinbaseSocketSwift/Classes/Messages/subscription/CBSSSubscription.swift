//
//  CBSSSubscription.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class CBSSSubscription {
    
    public let channel:CBSSChannel
    public let productIds:[CBSSProductId]
    
    public init(json: [String: Any]) throws {
        
        guard let channel = CBSSChannel(rawValue: json["name"] as? String ?? "") else {
            throw CBSSError.responseParsingFailure("subscription_name")
        }
        
        guard let productIdStrings = json["product_ids"] as? [String] else {
            throw CBSSError.responseParsingFailure("subscription_product_ids")
        }
        
        var productIdObjects = [CBSSProductId]()
        for productIdString in productIdStrings {
            guard let productId = CBSSProductId(rawValue: productIdString) else {
                throw CBSSError.responseParsingFailure("subscription_product_id")
            }
            
            productIdObjects.append(productId)
        }
        
        self.channel = channel
        self.productIds = productIdObjects
    }
}
