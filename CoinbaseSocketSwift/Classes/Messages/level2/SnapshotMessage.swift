//
//  SnapshotMessage.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

open class SnapshotMessage: ProductMessage {
    
    public let bids: [BidAsk]
    public let asks: [BidAsk]
    
    public required init(json: [String: Any]) throws {

        guard let bids = json["bids"] as? [[String]] else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("bids")
        }
        
        guard let asks = json["asks"] as? [[String]] else {
            throw CoinbaseSocketSwiftError.responseParsingFailure("asks")
        }
        
        var bidObjects = [BidAsk]()
        for bid in bids {
            guard let price = Double(bid[0]) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("bid_price")
            }
            
            guard let size = Double(bid[1]) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("bid_size")
            }
            
            bidObjects.append(BidAsk(type: .bid, price: price, size: size))
        }
        
        var askObjects = [BidAsk]()
        for ask in asks {
            guard let price = Double(ask[0]) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("ask_price")
            }
            
            guard let size = Double(ask[1]) else {
                throw CoinbaseSocketSwiftError.responseParsingFailure("ask_size")
            }
            
            askObjects.append(BidAsk(type: .ask, price: price, size: size))
        }
        
        self.bids = bidObjects
        self.asks = askObjects
        
        try super.init(json: json)
    }
}
