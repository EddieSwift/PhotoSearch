//
//  UIImageView+LoadImage.swift
//  PhotoSearch
//
//  Created by Eduard Galchenko on 27.01.2020.
//  Copyright © 2020 Eduard Galchenko. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(from url: URL?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        guard let imageUrl = url else { return }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }

    func loadImage(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        loadImage(from: url, contentMode: mode)
    }
}
