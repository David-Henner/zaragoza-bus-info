//
//  ApiManager.swift
//  zaragoza bus info
//
//  Created by David Henner on 05/01/2017.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ApiManager {
    
    static let sharedInstance = ApiManager()
    
    private struct routes {
        static let base = "http://api.dndzgz.com/services/"
        static let bus = base + "bus/"
    }
    
    init () {}
    
    func getLocations(completionHandler: @escaping ([BusStop]) -> Void) {
        Alamofire.request(routes.bus).responseArray(keyPath: "locations") {
            (response: DataResponse<[BusStop]>) in
            switch response.result {
            case .success(let busStops):
                completionHandler(busStops)
            case .failure(let error):
                print("Error getting bus stops: \(error)")
                completionHandler([BusStop]())
            }
        }
    }
    
    func getEstimates(withID id: String, completionHandler: @escaping ([Estimate]) -> Void) {
        Alamofire.request(routes.bus + id).responseArray(keyPath: "estimates") {
            (response: DataResponse<[Estimate]>) in
            switch response.result {
            case .success(let estimates):
                completionHandler(estimates)
            case .failure(let error):
                print("Error getting estimates: \(error)")
                completionHandler([Estimate]())
            }
        }
    }
    
}
