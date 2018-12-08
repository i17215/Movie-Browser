//
//  AboutMovieViewController.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 25/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

class AboutMovieViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieDetailsView: CircleView!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var poster: CustomImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorsLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var plotTextView: UITextView!
    
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var forthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    
    // MARK: - Properties
    
    private let client = OMDbAPIClient()
    var movie: Movie!
    
    // MARK: - Lifecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailsView.layer.masksToBounds = true
        movieDetailsView.layer.cornerRadius = 5
        
        setupView(with: movie)
    }
    
    // MARK: - Methods
    
    private func setupView(with movie: Movie) {
        runtimeLabel.text = movie.runtime
        titleLabel.text = movie.title
        genreLabel.text = movie.genre
        directorsLabel.text = movie.director
        actorsLabel.text = movie.actors
        plotTextView.text = movie.plot
        
        if let url = movie.posterUrl {
            poster.loadImage(from: url, indicator: nil)
        } else {
            poster.image = UIImage(named: "placeholder")
        }
        
        fillRatingStars(with: movie.rating!)
    }
    
    private func fillRatingStars(with imdbRating: String) {
        let rating = Float(imdbRating)!
        
        switch rating {
        case 0...2:
            firstStar.image = UIImage(named: "icon_star")
            
        case 2...4:
            firstStar.image = UIImage(named: "icon_star")
            secondStar.image = UIImage(named: "icon_star")
            
        case 4...6:
            firstStar.image = UIImage(named: "icon_star")
            secondStar.image = UIImage(named: "icon_star")
            thirdStar.image = UIImage(named: "icon_star")
            
        case 6...8:
            firstStar.image = UIImage(named: "icon_star")
            secondStar.image = UIImage(named: "icon_star")
            thirdStar.image = UIImage(named: "icon_star")
            forthStar.image = UIImage(named: "icon_star")
            
        case 8...10:
            firstStar.image = UIImage(named: "icon_star")
            secondStar.image = UIImage(named: "icon_star")
            thirdStar.image = UIImage(named: "icon_star")
            forthStar.image = UIImage(named: "icon_star")
            fifthStar.image = UIImage(named: "icon_star")
            
        default:
            firstStar.image = UIImage(named: "icon_empty_star")
            secondStar.image = UIImage(named: "icon_empty_star")
            thirdStar.image = UIImage(named: "icon_empty_star")
            forthStar.image = UIImage(named: "icon_empty_star")
            fifthStar.image = UIImage(named: "icon_empty_star")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
