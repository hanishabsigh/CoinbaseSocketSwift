//
//  CBSSReceived.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class CBSSReceived: CBSSProductSequenceTimeMessage {
    
    public let orderId: String
    public let size: Double?
    public let price: Double?
    public let side: CBSSSide
    public let orderType: CBSSOrderType
    public let funds: Double?
    
    public required init(json: [String: Any]) throws {
        
        guard let orderId = json["order_id"] as? String else {
            throw CBSSError.responseParsingFailure("order_id")
        }

        let size = Double(json["size"] as? String ?? "")
        
        let price = Double(json["price"] as? String ?? "")
        
        guard let side = CBSSSide(rawValue: json["side"] as? String ?? "") else {
            throw CBSSError.responseParsingFailure("side")
        }
        
        guard let orderType = CBSSOrderType(rawValue: json["order_type"] as? String ?? "") else {
            throw CBSSError.responseParsingFailure("order_type")
        }
        
        let funds = Double(json["funds"] as? String ?? "")

        self.orderId = orderId
        self.size = size
        self.price = price
        self.side = side
        self.orderType = orderType
        self.funds = funds
        
        try super.init(json: json)
    }
}
