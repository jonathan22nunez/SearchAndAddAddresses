//
//  SVC_Extension.swift
//  NunezJonathan_CE08
//
//  Created by Jonathan Nunez on 12/8/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import Foundation

extension SearchViewController {
    func readInJSON() {
        // Build path to .json file
        if let path = Bundle.main.path(forResource: "zips", ofType: ".json") {
            do {
                // Try build Data buffer using URL from path
                let data = try Data.init(contentsOf: URL(fileURLWithPath: path))
                // De-serialize to json object
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                // Parse JSON
                parseJSON(jsonObject: jsonObject)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func parseJSON(jsonObject: [Any]?) {
        guard let jsonObj = jsonObject else{return}
        
        // Iterate through JSON array and build Zipcodes, then add to zipcodesList
        for firstLevelItem in jsonObj {
            guard let object = firstLevelItem as? [String: Any]
                else{continue}
            
            self.zipcodesList.append(Zipcode(jsonObject: object)!)
        }
        // Reload the tableview data
        self.searchTableView.reloadData()
    }
}
