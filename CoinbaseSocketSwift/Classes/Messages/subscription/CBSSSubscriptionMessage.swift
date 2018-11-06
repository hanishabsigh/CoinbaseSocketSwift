//
//  CBSSSubscription.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class CBSSSubscriptionMessage {
    
    public let channels: [CBSSChannel]
    public let productIds: [CBSSProductId]
    
    public init(channels:[CBSSChannel], productIds:[CBSSProductId]) {
        self.channels = channels
        self.productIds = productIds
    }
    
    open func subscribeJSON(type: CBSSType, channels:[CBSSChannel], productIds:[CBSSProductId]) -> [String : Any] {
        let channels = self.channels.map { $0.rawValue }
        let productIds = self.productIds.map { $0.rawValue }
        
        var json = [String:Any]()
        json["type"] = type.rawValue
        json["product_ids"] = productIds
        json["channels"] = channels
        return json
    }
}
