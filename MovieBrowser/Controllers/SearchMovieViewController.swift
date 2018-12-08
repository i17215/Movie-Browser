//
//  SearchMovieViewController.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 25/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

protocol SearchMovieViewControllerDelegate: class {
    func addMovie(_ title: String)
}

class SearchMovieViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    // MARK: - Properties
    
    weak var delegate: SearchMovieViewControllerDelegate?
    
    let searchController = UISearchController(searchResultsController: nil)
    let dataSource = SearchResultsDataSource()
    let moviesDataBase = MoviesDataBase()
    let client = OMDbAPIClient()
    
    // MARK: - Lifecercle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        resultsTableView.dataSource = dataSource
        definesPresentationContext = true
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        searchController.isActive = false
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = resultsTableView.indexPathForSelectedRow {
                let movie = dataSource.movie(at: indexPath)
                let aboutMovieViewController = segue.destination as! AboutMovieViewController

                aboutMovieViewController.movie = movie
            }
        }
    }
}

// MARK: - UISearchResultsUpdating

extension SearchMovieViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        client.loadMovieDataFor(movie: searchController.searchBar.text!) { [weak self] movie in
            self?.dataSource.update(with: movie)
            self?.resultsTableView.reloadData()
        }
    }
}

extension SearchMovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let add = UITableViewRowAction(style: .default, title: "Add") { (action, indexPath) in
            let movie = self.dataSource.movie(at: indexPath)
            
            self.delegate?.addMovie(movie.title!)
        }
        
        add.backgroundColor = UIColor.lightGray
        
        return[add]
    }
}
