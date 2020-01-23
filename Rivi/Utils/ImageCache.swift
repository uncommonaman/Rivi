//
//  ImageCache.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
   

    private var cache = NSCache<NSString,UIImage>()
    
 
    private init() { }
    
    subscript(key: String) -> UIImage? {
        get {
            return cache.object(forKey: key as NSString)
        }
        
        set (newValue) {
            guard let exist = newValue else { return }
            cache.setObject(exist, forKey: key as NSString)
        }
    }
}
