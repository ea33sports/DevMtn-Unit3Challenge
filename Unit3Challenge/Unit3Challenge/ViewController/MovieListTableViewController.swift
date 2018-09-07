//
//  MovieListTableViewController.swift
//  Unit3Challenge
//
//  Created by Eric Andersen on 9/7/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        MovieController.shared.fetchPosts(by: searchTerm) {_ in
            DispatchQueue.main.async {
                self.title = "\(searchTerm)"
                self.tableView.reloadData()
            }
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MovieController.shared.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = MovieController.shared.movies[indexPath.row]
        
        // Configure the cell...
        cell.movie = movie

        return cell
    }
}
