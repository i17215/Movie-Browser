//
//  MovieDataBase.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 23/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

class MoviesDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    var data = [Movie]()
    private let client = OMDbAPIClient()
    
    override init() {
        super.init()
    }
    
    // MARK: - Methods
    
    func update(with movies: [Movie]) {
        data = movies
    }
    
    // MARK: - UICollectionView Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = data[indexPath.row]
        
        if let movieFromCache = client.movieDataCache.object(forKey: "movieData" as AnyObject) as? Movie {
            cell.titleLabel.text = movieFromCache.title
            cell.genreLabel.text = movieFromCache.genre
            cell.yearLabel.text = movieFromCache.year
            cell.runtimeLabel.text = movieFromCache.runtime
            cell.ratingLabel.text = movieFromCache.rating
        }
        
        cell.activityIndicator.startAnimating()
        
        cell.titleLabel.text = movie.title
        cell.genreLabel.text = movie.genre
        cell.yearLabel.text = movie.year
        cell.runtimeLabel.text = movie.runtime
        cell.ratingLabel.text = movie.rating
        
        if let url = movie.posterUrl {
            cell.poster.loadImage(from: url, indicator: cell.activityIndicator)
        } else {
            cell.poster.image = UIImage(named: "placeholder")
        }
    
        return cell
    }
}
