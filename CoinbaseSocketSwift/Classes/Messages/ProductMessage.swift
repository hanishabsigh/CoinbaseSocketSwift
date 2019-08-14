//
//  ProductMessage.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class ProductMessage: CoinbaseMessage {
    
    public let productId: String

    public required init(json: [String: Any]) throws {
        
        guard let productId = json["product_id"] as? String else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("user_id")
        }
        
        self.productId = productId
        
        try super.init(json: json)
    }
}
