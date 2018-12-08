//
//  UIViewExtension.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 21/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

extension UIView {
    
    /// The function that create round view of UIView
    func setRounded() {
        // Check iPhone screen size
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136, 1334: // iPhone 5 or 5S or 5C & iPhone 6/6S/7/8
                self.layer.cornerRadius = self.frame.size.width / 2.5
                self.clipsToBounds = true
                
            default: // Other iPhones
                self.layer.cornerRadius = self.frame.size.width / 2
                self.clipsToBounds = true
            }
        }
    }
}
