//
//  UIImageView+Extensions.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func load(url: URL) {
        if let image = ImageCache.shared[url.absoluteString]{
            self.image = image
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCache.shared[url.absoluteString] = image
                        self?.image = image
                    }
                }
            }
        }
    }
}
