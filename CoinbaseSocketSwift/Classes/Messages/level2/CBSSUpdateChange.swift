//
//  CBSSUpdateChange.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class CBSSUpdateChange {
    
    public let side: CBSSSide
    public let price: Double
    public let size: Double
    
    public init(side: CBSSSide, price: Double, size: Double) {
        self.side = side
        self.price = price
        self.size = size
    }
}
