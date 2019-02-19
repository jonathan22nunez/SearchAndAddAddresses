//
//  SearchViewController.swift
//  NunezJonathan_CE08
//
//  Created by Jonathan Nunez on 12/8/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: Preparations
    @IBOutlet weak var searchTableView: UITableView!
    var zipcodesList = [Zipcode]()
    var filteredZipcodes = [Zipcode]()
    
    // Set SearchController to searchResultsController to nil, meaning that this VC will handle the searchbar
    var searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Set up search controller
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        // Set searchBar placeholder text
        searchController.searchBar.placeholder = "Search by City"
        
        // To receive updates to searches here in this TableViewController
        searchController.searchResultsUpdater = self
        
        // Set up search bar of search controller
        searchController.searchBar.scopeButtonTitles = ["All", "FL", "TX"]
        searchController.searchBar.delegate = self
        
        // Set the searchbar within the navigationbar
        navigationItem.searchController = searchController
        // Set the navigation bar title
        navigationItem.title = "Zipcodes List"
        
        // Set the tableview dataSource to self
        searchTableView.dataSource = self
        
        // Method to populate tableview
        readInJSON()
        
        // Set the filteredZipcodes to the created zipcodesList
        filteredZipcodes = zipcodesList
    }
    // TableView callbacks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Set number of rows in section to the count of filteredZipcodes
        return filteredZipcodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set custom tableview cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID", for: indexPath) as! SearchTableViewCell
        
        // Set label properties
        cell.cityStateLabel.text = filteredZipcodes[indexPath.row].cityState
        cell.zipcodeLabel.text = filteredZipcodes[indexPath.row].zipcode
        cell.latitudeLabel.text = filteredZipcodes[indexPath.row].lattitude
        cell.longitudeLabel.text = filteredZipcodes[indexPath.row].longitude
        
        return cell
    }
    
    // Searchbar callbacks
    func updateSearchResults(for searchController: UISearchController) {
        // Get the text our user wants to search for
        let searchText = searchController.searchBar.text
        
        // Get the scope button title that the user selected
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
        let allScopeTitles = searchController.searchBar.scopeButtonTitles!
        let scopeTitle = allScopeTitles[selectedScope]
        
        // Filter our content
        // Dump our full data set into the array we will use for filtering
        filteredZipcodes = zipcodesList
        
        // If the user typed anything into the search field, then filter based on that entry
        if searchText != "" {
            filteredZipcodes = filteredZipcodes.filter(
                {
                    $0.city.lowercased().range(of: searchText!.lowercased()) != nil
            })
        }
        
        // Filter again based on scope
        if scopeTitle != "All" {
            filteredZipcodes = filteredZipcodes.filter(
                {
                    $0.state.range(of: scopeTitle) != nil
            })
        }
        searchTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // Call the updateSearchResults
        updateSearchResults(for: searchController)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Allow for search keyboard button to unwind to root VC
        performSegue(withIdentifier: "unwindIdentifier", sender: self)
    }
}
