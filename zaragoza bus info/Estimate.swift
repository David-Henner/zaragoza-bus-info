//
//  Estimate.swift
//  zaragoza bus info
//
//  Created by David Henner on 05/01/2017.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import ObjectMapper

class Estimate : Mappable {
    var line: String?
    var direction: String?
    var estimate: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        line <- map["line"]
        direction <- map["direction"]
        estimate <- map["estimate"]
    }
}
