//
//  PhotoTableViewCell.swift
//  PhotoSearch
//
//  Created by Eduard Galchenko on 22.01.2020.
//  Copyright © 2020 Eduard Galchenko. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    // MARK: - Properties

    private var searchLabel: UILabel!
    var photoImageView: ImageLoader!

    // MARK: - Init and Configure Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureWith(photoResult: PhotoResult) {
        searchLabel.text = photoResult.searchTerm

        if let strUrl = photoResult.photoURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let imgUrl = URL(string: strUrl) {
            photoImageView.loadImageWithUrl(imgUrl)
        }
    }

    // MARK: - Setup UI Methods

    private func setupUI() {
        setupSearchLabelUI()
        setupPhotoImageUI()
    }

    private func setupSearchLabelUI() {
        searchLabel = UILabel()
        contentView.addSubview(searchLabel)
        searchLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            searchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            searchLabel.heightAnchor.constraint(equalToConstant: 40),
            searchLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupPhotoImageUI() {
        photoImageView = ImageLoader()
        contentView.addSubview(photoImageView)
        photoImageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            photoImageView.heightAnchor.constraint(equalToConstant: 90),
            photoImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
}
