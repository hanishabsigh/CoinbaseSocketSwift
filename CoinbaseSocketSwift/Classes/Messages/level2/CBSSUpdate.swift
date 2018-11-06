//
//  CBSSUpdate.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

open class CBSSUpdate: CBSSProductMessage {
    
    public let changes: [CBSSUpdateChange]
    
    public required init(json: [String: Any]) throws {
        
        guard let changes = json["changes"] as? [[String]] else {
            throw CBSSError.responseParsingFailure("changes")
        }
        
        var changeObjects = [CBSSUpdateChange]()
        for change in changes {
            guard let side = CBSSSide(rawValue: change[0]) else {
                throw CBSSError.responseParsingFailure("change_side")
            }
            
            guard let price = Double(change[1]) else {
                throw CBSSError.responseParsingFailure("change_price")
            }
            
            guard let size = Double(change[2]) else {
                throw CBSSError.responseParsingFailure("change_size")
            }
            
            changeObjects.append(CBSSUpdateChange(side: side, price: price, size: size))
        }
        
        self.changes = changeObjects
        
        try super.init(json: json)
    }
}
