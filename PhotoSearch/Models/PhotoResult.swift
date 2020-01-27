//
//  PhotoResult.swift
//  PhotoSearch
//
//  Created by Eduard Galchenko on 27.01.2020.
//  Copyright © 2020 Eduard Galchenko. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoResult: Object {
    @objc dynamic var searchTerm = ""
    @objc dynamic var photoURL = ""
}
