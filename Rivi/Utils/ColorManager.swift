//
//  ColorManager.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import UIKit

enum ColorManager {
    
    case Default
    
    // Navigation Bar Color
    var blueFontColor: UIColor{
        switch self {
        case .Default:
            return UIColor(red: 0.16, green: 0.54, blue: 0.79, alpha: 1)
        }
    }
    
    var grayFontColor: UIColor{
           switch self {
           case .Default:
               return UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1)
           }
       }
    
    var borderColor: UIColor{
        switch self {
        case .Default:
            return UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        }
    }
       
    
}
