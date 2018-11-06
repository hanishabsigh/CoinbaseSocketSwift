//
//  CBSSSnapshot.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

open class CBSSSnapshot: CBSSProductMessage {
    
    public let bids: [CBSSBidAsk]
    public let asks: [CBSSBidAsk]
    
    public required init(json: [String: Any]) throws {

        guard let bids = json["bids"] as? [[String]] else {
            throw CBSSError.responseParsingFailure("bids")
        }
        
        guard let asks = json["asks"] as? [[String]] else {
            throw CBSSError.responseParsingFailure("asks")
        }
        
        var bidObjects = [CBSSBidAsk]()
        for bid in bids {
            guard let price = Double(bid[0]) else {
                throw CBSSError.responseParsingFailure("bid_price")
            }
            
            guard let size = Double(bid[1]) else {
                throw CBSSError.responseParsingFailure("bid_size")
            }
            
            bidObjects.append(CBSSBidAsk(type: .bid, price: price, size: size))
        }
        
        var askObjects = [CBSSBidAsk]()
        for ask in asks {
            guard let price = Double(ask[0]) else {
                throw CBSSError.responseParsingFailure("ask_price")
            }
            
            guard let size = Double(ask[1]) else {
                throw CBSSError.responseParsingFailure("ask_size")
            }
            
            askObjects.append(CBSSBidAsk(type: .ask, price: price, size: size))
        }
        
        self.bids = bidObjects
        self.asks = askObjects
        
        try super.init(json: json)
    }
}
