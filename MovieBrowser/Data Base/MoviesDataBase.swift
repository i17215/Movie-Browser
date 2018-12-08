//
//  MoviesDataBase.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 24/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import Foundation

/// Class that contains array with my favorite movies
class MoviesDataBase {
    
    var movies = [
        "Father of the Bride",
        "Captain America: The First Avenger",
        "Grown Ups",
        "Just Go with It",
        "The Wedding Singer",
        "Passengers",
        "Wall-E",
        "Toy Story",
        "Iron Man",
        "Spider-Man", // 10
        "Ant-Man",
        "Thor",
        "Cars",
        "The Fast and the Furious",
        "Zodiac",
        "Secret Window",
        "Pirates of the Caribbean",
        "You Don't Mess with the Zohan",
        "Happy Gilmore",
        "Bedtime Stories", // 20
        "50 First Dates",
        "Blended",
        "Mr. Deeds",
        "The Girl with the Dragon Tattoo",
        "Jurassic World",
        "Guardians of the Galaxy",
        "A Beautiful Mind",
        "Sherlock Holmes",
        "Howl's Moving Castle",
        "My Neighbor Totoro", // 30
        "Ponyo"
    ]
    
    func addMovie(title: String) {
        movies.append(title)
    }
}
