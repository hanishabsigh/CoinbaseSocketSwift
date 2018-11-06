//
//  CBSSOpen.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

public class CBSSOpen: CBSSProductSequenceTimeMessage {
    
    public let orderId: String
    public let price: Double
    public let remainingSize: Double
    public let side: CBSSSide
    
    public required init(json: [String: Any]) throws {
        
        guard let orderId = json["order_id"] as? String else {
            throw CBSSError.responseParsingFailure("order_id")
        }
        
        guard let price = Double(json["price"] as? String ?? "") else {
            throw CBSSError.responseParsingFailure("price")
        }
        
        guard let remainingSize = Double(json["remaining_size"] as? String ?? "") else {
            throw CBSSError.responseParsingFailure("remaining_size")
        }
        
        guard let side = CBSSSide(rawValue: json["side"] as? String ?? "") else {
            throw CBSSError.responseParsingFailure("side")
        }
        
        self.orderId = orderId
        self.remainingSize = remainingSize
        self.price = price
        self.side = side
        
        try super.init(json: json)
    }
}
