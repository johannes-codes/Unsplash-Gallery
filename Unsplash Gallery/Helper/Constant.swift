//
//  Constant.swift
//  Unsplash Gallery
//
//  Created by Meißner, Johannes, HSE DE on 13.10.23.
//

import Foundation

var apiKey: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "config", ofType: "plist") else {
            fatalError("Couldn't find file 'config.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'config.plist'.")
        }
        return value
    }
}
