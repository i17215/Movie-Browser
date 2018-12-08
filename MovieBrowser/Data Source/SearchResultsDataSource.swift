//
//  SearchResultsDataSource.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 25/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    private var data: Movie!
    
    // MARK: - Methods
    
    func update(with movies: Movie) {
        data = movies
    }
    
    func movie(at indexPath: IndexPath) -> Movie {
        return data
    }
    
    // MARK: - UITableView Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data == nil {
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath)
        
        cell.textLabel?.text = data.title
        
        return cell
    }
}
