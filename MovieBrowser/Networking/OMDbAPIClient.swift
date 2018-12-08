//
//  OMDbAPIClient.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 24/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

/// Client for working with API of http://www.omdbapi.com
class OMDbAPIClient {
    
    // MARK: - Properties
    
    private let apiKey = "25a4f6c1"
    let movieDataCache = NSCache<AnyObject, AnyObject>()
    
    // MARK: - Methods
    
    /// Downloading information about movie
    func loadMovieDataFor(movie title: String, completion: @escaping(Movie) -> Void) {
        let formattedTitle = title.removeWhitespacesAndColons()
        let url = URL(string: "http://www.omdbapi.com/?apikey=\(apiKey)&t=\(formattedTitle)&plot=full")
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(Movie.self, from: data)
                    
                    self.movieDataCache.setObject(response as AnyObject, forKey: title as AnyObject)
                    
                    completion(response)
                } catch let error {
                    print("Error", error)
                }
            }
        }
        
        task.resume()
    }
}
