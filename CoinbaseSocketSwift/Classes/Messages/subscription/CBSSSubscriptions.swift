//
//  CBSSSubscriptions.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class CBSSSubscriptions: CBSSMessage {
    
    public let channels: [CBSSSubscription]
    
    public required init(json: [String: Any]) throws {
        
        guard let channelJSONs = json["channels"] as? [[String: Any]] else {
            throw CBSSError.responseParsingFailure("subscriptions_channels")
        }
        
        var channelObjects = [CBSSSubscription]()
        for channelJSON in channelJSONs {
            guard let channel = try? CBSSSubscription(json: channelJSON) else {
                throw CBSSError.responseParsingFailure("subscriptions_channel")
            }
            
            channelObjects.append(channel)
        }
        
        self.channels = channelObjects
        
        try super.init(json: json)
    }
}
