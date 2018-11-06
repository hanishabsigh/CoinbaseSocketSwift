//
//  ProductMessage.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class ProductMessage: CoinbaseMessage {
    
    public let productId: ProductId

    public required init(json: [String: Any]) throws {
        
        guard let productId = ProductId(rawValue: json["product_id"] as? String ?? "") else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("product_id")
        }
        
        self.productId = productId
        
        try super.init(json: json)
    }
}
