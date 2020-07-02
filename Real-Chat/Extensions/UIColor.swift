//
//  UIColor.swift
//  Real-Chat
//
//  Created by Dinesh Danda on 7/2/20.
//  Copyright © 2020 Dinesh Danda. All rights reserved.
//

import UIKit


extension UIColor {
    
    static let logInBGC = UIColor(red: 0.88, green: 0.35, blue: 0.16, alpha: 1)
    static let backgroundWhite = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
    
    class func hexaToUIColor(hex: String, alpha: CGFloat = 1.0) -> UIColor? {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: alpha)
    }
    
    
    
    
}
