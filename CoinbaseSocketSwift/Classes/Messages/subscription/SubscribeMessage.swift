//
//  SubscribeMessage.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/28/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class SubscribeMessage: SubscriptionMessage, JSONConvertible {
    
    open func asJSON() -> [String : Any] {
        return subscribeJSON(type: .subscribe, channels: self.channels, productIds: self.productIds)
    }
}
