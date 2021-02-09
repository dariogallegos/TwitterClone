//
//  ImageLoader.swift
//  TwitterClone
//
//  Created by Dario Gallegos on 3/2/21.
//  Copyright © 2021 Dario Gallegos. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        self.contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.sync {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
