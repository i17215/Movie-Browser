//
//  StringExtension.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 24/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import Foundation

extension String {
    
    /// Custom formatting of String that replace " " & ":"
    func removeWhitespacesAndColons() -> String {
        let string = self.replacingOccurrences(of: " ", with: "+")
                         .replacingOccurrences(of: ":", with: "%3A")
        return string
    }
}
