//
//  MovieCollectionViewCell.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 18/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var poster: CustomImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}
