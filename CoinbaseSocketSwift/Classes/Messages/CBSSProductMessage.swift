//
//  CBSSProductMessage.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class CBSSProductMessage: CBSSMessage {
    
    public let productId: CBSSProductId

    public required init(json: [String: Any]) throws {
        
        guard let productId = CBSSProductId(rawValue: json["product_id"] as? String ?? "") else {
            throw CBSSError.responseParsingFailure("product_id")
        }
        
        self.productId = productId
        
        try super.init(json: json)
    }
}
