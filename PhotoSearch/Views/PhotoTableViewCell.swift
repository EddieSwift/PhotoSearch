//
//  PhotoTableViewCell.swift
//  PhotoSearch
//
//  Created by Eduard Galchenko on 22.01.2020.
//  Copyright © 2020 Eduard Galchenko. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    public static let identifier = "PhotoTableViewCell"
    private static let nibName   = "PhotoTableViewCell"
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    
    public static func register(in tableView: UITableView) {
        let nib = UINib.init(nibName: nibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func configureWith(searchResult: SearchResult) {
        searchLabel.text = searchResult.searchTerm
        photoImageView.image = searchResult.searchResult[0].thumbnail
    }
    
}
