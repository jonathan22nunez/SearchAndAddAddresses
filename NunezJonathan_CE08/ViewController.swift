//
//  ViewController.swift
//  NunezJonathan_CE08
//
//  Created by Jonathan Nunez on 12/7/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Preparations
    var searchedZipcodes = [Zipcode]()
    @IBOutlet weak var searchedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set tableview dataSource to self
        searchedTableView.dataSource = self
        
        // Set the navigation bar title
        navigationItem.title = "Start with a Search"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Set the number of cells in section to the searchedZipcodes array
        return searchedZipcodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use custom tableview cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! SearchedTableViewCell
        
        // Set label properties
        cell.cityStateLabel.text = searchedZipcodes[indexPath.row].cityState
        cell.zipcodeLabel.text = searchedZipcodes[indexPath.row].zipcode
        cell.latitudeLabel.text = searchedZipcodes[indexPath.row].lattitude
        cell.longitutdeLabel.text = searchedZipcodes[indexPath.row].longitude
        
        return cell
    }

    @IBAction func clearTapped(_ sender: UIBarButtonItem) {
        // Remove all the objects in the searchZipcodes array
        searchedZipcodes.removeAll()
        
        // Reload the tableview data
        searchedTableView.reloadData()
        
        // Reset the navigation bar title
        navigationItem.title = "Start with a Search"
    }
    
    @IBAction func unwindToRoot(_ segue: UIStoryboardSegue) {
        // Handle passback from SearchViewController
        if let source = segue.source as? SearchViewController {
            // Set the searchedZipcodes to the filtered zipcodes from source
            searchedZipcodes = source.filteredZipcodes
            
            // Reload tableview data
            searchedTableView.reloadData()
            
            // Update navigation bar title
            navigationItem.title = "Search Results"
        }
    }
    
}

