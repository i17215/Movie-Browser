//
//  ViewController.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 18/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//
// icons get from: https://www.iconfinder.com/ZFros
//

import UIKit
import MessageUI

class MoviesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var movieBrowserView: UIView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!

    @IBOutlet weak var moviewBrowserViewTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    private let dataBase = MoviesDataBase()
    private let moviesDataSource = MoviesDataSource()
    private let client = OMDbAPIClient()
    private var movies = [Movie]()
    
    // MARK: - Lifecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        loadInfoAboutMovies()
    }
    
    // MARK: - Methods
    
    private func configureView() {
        // Register collection view cell
        self.moviesCollectionView.register(UINib(nibName: "MovieCell", bundle: nil),
                                           forCellWithReuseIdentifier: "movieCell")
        moviesCollectionView.dataSource = moviesDataSource
        
        // Round the adges of avatar background and avatar image view
        imageView.setRounded()
        avatar.setRounded()
        
        // Round the adges of buttons on profile view
        cancelButton.setRounded()
        callButton.setRounded()
        emailButton.setRounded()
    }
    
    /// Function that get all information about movies
    private func loadInfoAboutMovies() {
        if userDefaults.object(forKey: "favoriteMovies") != nil {
            let array = userDefaults.object(forKey: "favoriteMovies") as? [String] ?? [String]()
            
            array.forEach { title in
                loadInformationAboutMovie(with: title)
            }
        } else {
            dataBase.movies.forEach { title in
                loadInformationAboutMovie(with: title)
            }
        }
    }
    
    /// Collect Data about movie from server and save it to local array
    private func loadInformationAboutMovie(with title: String) {
        self.client.loadMovieDataFor(movie: title, completion: { movie in
            self.movies.append(movie)
            self.moviesDataSource.update(with: self.movies)
            
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        })
    }
    
    // MARK: - Actions
    
    @IBAction func showProfileButtonTapped(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.moviewBrowserViewTrailingConstraint.constant = -self.profileView.frame.size.width
            self.movieBrowserView.alpha = 0.5
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.moviewBrowserViewTrailingConstraint.constant = 0
            self.movieBrowserView.alpha = 1
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "tel://+7(903)333-14-03)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeViewController.setToRecipients(["k.koleno@icloud.com"])
            composeViewController.setSubject("Message from Movie Browser app")
            composeViewController.setMessageBody("", isHTML: false)
            
            // Present the view controller modally.
            self.present(composeViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearchView" {
            if let searchViewController = segue.destination as? SearchMovieViewController {
                searchViewController.delegate = self
            }
        }
    }
}

// MARK: - CollectionView Delegate

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width / 2
        let height = self.view.frame.height / 2.7
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let aboutViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "aboutMovieViewController") as! AboutMovieViewController
        
        let movie = movies[indexPath.row]
        
        aboutViewController.movie = movie
        
        aboutViewController.modalPresentationStyle = .overCurrentContext
        aboutViewController.modalTransitionStyle = .crossDissolve
        present(aboutViewController, animated: true, completion: nil)
    }
}

// MARK: - MFMailComposeViewController Delegate

extension MoviesViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension MoviesViewController: SearchMovieViewControllerDelegate {
    
    func addMovie(_ title: String) {
        self.dataBase.addMovie(title: title)
        
        // Save loved movies to UserDefaults
        userDefaults.set(dataBase.movies, forKey: "favoriteMovies")
        
        loadInformationAboutMovie(with: title)
    }
}
