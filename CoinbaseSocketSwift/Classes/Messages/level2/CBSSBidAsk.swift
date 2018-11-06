//
//  CBSSBidAsk.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

public enum CBSSBidAskType: String {
    
    case bid, ask
}

open class CBSSBidAsk {
    
    public let type: CBSSBidAskType
    public let price: Double
    public let size: Double
    
    public init(type: CBSSBidAskType, price: Double, size: Double) {
        self.type = type
        self.price = price
        self.size = size
    }
}
