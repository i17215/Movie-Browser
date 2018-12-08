//
//  Movie.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 23/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

/// Model of Movie
struct Movie: Codable {
    
    let title: String?
    let year: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let actors: String?
    let plot: String?
    let posterUrl: String?
    let rating: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case posterUrl = "Poster"
        case rating = "imdbRating"
    }
}
