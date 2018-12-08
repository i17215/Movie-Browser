//
//  CustomImageView.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 25/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var imageUrlString: String?
    
    /// Downloading movie poster
    func loadImage(from urlString: String, indicator: UIActivityIndicatorView?) {
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let imageData = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: imageData)!
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                indicator?.stopAnimating()
                
                self.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
            }
            
            }.resume()
    }
}
