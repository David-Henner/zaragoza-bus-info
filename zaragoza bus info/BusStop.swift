//
//  BusStop.swift
//  zaragoza bus info
//
//  Created by David Henner on 05/01/2017.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import ObjectMapper

class BusStop : Mappable {
    var id: String?
    var title: String?
    var lines: [String]?
    var lat: Double?
    var lon: Double?
    var mapUrl: String?
    var estimates = [Estimate]()
    
    private let mapsApiKey = "AIzaSyCShkrVFolcSqopdECdXxvymVE7VXecC_U"
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        lines <- map["lines"]
        lat <- map["lat"]
        lon <- map["lon"]
        self.setMapUrl()
        self.loadEstimates()
    }
    
    func loadEstimates() {
        if let id = id {
            ApiManager.sharedInstance.getEstimates(withID: id) {
                estimates in
                if !estimates.isEmpty {
                    self.estimates = estimates
                }
            }
        }
    }
    
    func setMapUrl() {
        if let lat = self.lat, let lon = self.lon {
            self.mapUrl = "http://maps.googleapis.com/maps/api/staticmap?center=" + String(lat) + "," + String(lon)
                + "&markers=size:tiny%7C" + String(lat) + "," + String(lon)
                + "&zoom=15&size=100x100&sensor=true&key=" + mapsApiKey
        }
    }
}
