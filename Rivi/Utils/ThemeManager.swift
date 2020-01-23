//
//  ThemeManager.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import UIKit

enum ThemeManager{
    
    case Default
    
    // App Color Manager
    var colorManager: ColorManager{
        switch self {
        case .Default:
            return ColorManager.Default
        }
    }
    
   
    func montserratSemiBoldFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-SemiBold", size: size)
    }
    
    func montserratMediumFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Medium", size: size)
    }
    
    func montserratExtraBoldFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-ExtraBold", size: size)
        
    }
    
    func montserratBoldFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Bold", size: size)
    }
    
   

    

    
    // Corner Radius
    var smallCornerRadius: CGFloat{
        switch self {
        case .Default:
            return 5
        }
    }
    
    var largeCornerRadius: CGFloat{
        switch self {
        case .Default:
            return 10
        }
    }
    
    var creationActionButton: CGFloat{
        switch self {
        case .Default:
            return 60
        }
    }
}
