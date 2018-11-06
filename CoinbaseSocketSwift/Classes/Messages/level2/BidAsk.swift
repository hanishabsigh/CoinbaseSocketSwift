//
//  BidAsk.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

public enum BidAskType: String {
    
    case bid, ask
}

open class BidAsk {
    
    public let type: BidAskType
    public let price: Double
    public let size: Double
    
    public init(type: BidAskType, price: Double, size: Double) {
        self.type = type
        self.price = price
        self.size = size
    }
}
