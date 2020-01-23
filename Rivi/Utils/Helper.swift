//
//  Helper.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import Foundation
import UIKit
class Helper {
    static let shared = Helper()
    private init() { }
    
    func formatMultiline(items:[String]?) -> String? {
        guard let items = items else { return nil }
        if items.count > 1 {
            let formmatedText = items.enumerated().map { (index,item) -> String in
                let text = "\(index+1). \(item)"
                return text
            }
            return formmatedText.joined(separator: "\n")
        } else if items.count == 1  {
            let item = items.first
            return item
            
        } else {
            return nil
        }
        
    }
    
    func createShadowLayer(cornerRadius:CGFloat,bounds:CGRect) -> CAShapeLayer {
        
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
       
        shadowLayer.shadowColor =  UIColor(red: 0.66, green: 0.67, blue: 0.74, alpha: 0.25).cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.80
        return shadowLayer
    }
    
}

