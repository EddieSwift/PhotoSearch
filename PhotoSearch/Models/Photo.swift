//
//  Photo.swift
//  PhotoSearch
//
//  Created by Eduard Galchenko on 22.01.2020.
//  Copyright © 2020 Eduard Galchenko. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    var thumbnail: UIImage?
    var largeImage: UIImage?
    let photoID: String
    let farm: Int
    let server: String
    let secret: String
    
    init (photoID: String, farm: Int, server: String, secret: String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    func flickrImageURL(_ size: String = "m") -> String {
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg") {
            return url.absoluteString
        }
        return ""
    }
    
    enum Error: Swift.Error {
        case invalidURL
        case noData
    }
}
