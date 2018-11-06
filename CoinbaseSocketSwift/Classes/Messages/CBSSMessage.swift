//
//  CBSSMessage.swift
//  CBSSSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

open class CBSSMessage: NSObject, JSONInitializable {
    
    public let type: CBSSType

    public required init(json: [String: Any]) throws {

        guard let type = CBSSType(rawValue: json["type"] as? String ?? "") else {
            throw CBSSError.responseParsingFailure("type")
        }
        
        self.type = type
    }
}
