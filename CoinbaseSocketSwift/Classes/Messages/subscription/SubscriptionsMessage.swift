//
//  SubscriptionsMessage.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class SubscriptionsMessage: CoinbaseMessage {
    
    public let channels: [Subscription]
    
    public required init(json: [String: Any]) throws {
        
        guard let channelJSONs = json["channels"] as? [[String: Any]] else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("subscriptions_channels")
        }
        
        var channelObjects = [Subscription]()
        for channelJSON in channelJSONs {
            guard let channel = try? Subscription(json: channelJSON) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("subscriptions_channel")
            }
            
            channelObjects.append(channel)
        }
        
        self.channels = channelObjects
        
        try super.init(json: json)
    }
}
