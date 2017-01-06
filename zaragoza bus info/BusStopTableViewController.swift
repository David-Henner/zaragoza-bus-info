//
//  BusStopTableViewController.swift
//  zaragoza bus info
//
//  Created by David Henner on 05/01/2017.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class BusStopTableViewController: UITableViewController {
    
    var busStops = [BusStop]()
    var filteredBusStops = [BusStop]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up the searchcontroller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        // Requesting busStops
        ApiManager.sharedInstance.getLocations() {
            busStops in
            if !busStops.isEmpty {
                self.busStops = busStops
                self.tableView.reloadData()
            }
        }
    }
    
    // Refreshes the tableview
    @IBAction func refreshAction(_ sender: AnyObject) {
        self.tableView.reloadData()
    }
    
    // Filters the bus Stops
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredBusStops = busStops.filter { busStop in
            if let title = busStop.title, let number = busStop.id {
                return title.lowercased().contains(searchText.lowercased()) || number.lowercased().contains(searchText.lowercased())
            }
            return false
        }
        tableView.reloadData()
    }
}


extension BusStopTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

// Table view data source
extension BusStopTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredBusStops.count
        }
        return busStops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "busStopCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BusStopTableViewCell
    
        var busStop: BusStop

        if searchController.isActive && searchController.searchBar.text != "" {
            busStop = filteredBusStops[indexPath.row]
        }
        else {
            busStop = busStops[indexPath.row]
        }
    
        cell.busStop = busStop
        cell.busStop?.loadEstimates()
        if let id = busStop.id, let title = busStop.title {
            cell.stopNumber.text = id
            cell.stopTitle.text = title
        }
        if let url = busStop.mapUrl {
            cell.mapView.kf.setImage(with: URL(string: url))
        }

        return cell
    }

}
