//
//  UIColor+Extension.swift
//  BeiJingJiaoJing
//
//  Created by Rocky on 2017/3/7.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func colorWithHexRGB(_ rgbValue:Int,alpha:CGFloat = 1.0) -> UIColor{
    
         return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0xFF)/255.0, alpha: alpha)
    }
    
    class func colorWithHexString(_ colorHex: NSString) -> UIColor {
        
        let rString = colorHex.substring(with: NSMakeRange(0, 2))
        let gString = colorHex.substring(with: NSMakeRange(2, 2))
        let bString = colorHex.substring(with: NSMakeRange(4, 2))
        
        var r: UInt32 = 0 , g: UInt32 = 0, b: UInt32 = 0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    class func colorWithRGBA(red:Float,green:Float,blue:Float,alpha:Float = 1.0) -> UIColor{
    
        return UIColor(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    struct Main {
        
        static let blue:UIColor = UIColor.colorWithRGBA(red: 0 , green: 132, blue: 255)
        
        struct gray {
            
            static let dark:UIColor = UIColor.colorWithRGBA(red: 25, green: 25, blue: 25)
            
            static let weak:UIColor = UIColor.colorWithRGBA(red: 153, green: 153, blue: 153)
            
            static let middle:UIColor = UIColor.colorWithRGBA(red: 102, green: 102, blue: 102)
        }
        
        static let backgroundGray:UIColor = UIColor.colorWithHexString("f8f8f8")
        
    }
}
