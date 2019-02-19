//
//  Zipcode.swift
//  NunezJonathan_CE08
//
//  Created by Jonathan Nunez on 12/8/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import Foundation

class Zipcode {
    // Stored properties
    let city: String
    var location = [Double]()
    let state: String
    let id: String
    
    // Computed properties
    var cityState: String {
        return self.city + ", " + self.state
    }
    
    var zipcode: String {
        return "Zipcode: " + self.id
    }
    
    var lattitude: String {
        return "Lat.: " + String(format: "%.4f", location[0])
    }
    
    var longitude: String {
        return "Long.: " + String(format: "%.4f", location[1])
    }
    
    // Optional initializer
    init?(jsonObject: [String: Any]) {
        // Guard to make sure JSON has all object properties, otherwise return nil
        guard let city = jsonObject["city"] as? String,
            let location = jsonObject["loc"] as? [Any],
            let state = jsonObject["state"] as? String,
            let id = jsonObject["_id"] as? String
            else{return nil}
        
        // Set self.properties
        self.city = city
        for secondLevelItem in location {
            guard let loc = secondLevelItem as? Double else{continue}
            
            self.location.append(loc)
        }
        self.state = state
        self.id = id
    }
}
