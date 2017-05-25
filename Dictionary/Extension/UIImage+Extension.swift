//
//  UIImage+Extension.swift
//  BeiJingJiaoJing
//
//  Created by Rocky on 2017/4/19.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    /// 通过颜色生成图片
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - andFrame: 大小 (默认值 0,0 ,1,1)
    /// - Returns: image
    final class func imageWithColor(_ color:UIColor,andFrame:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)) ->
        UIImage?{
    
        UIGraphicsBeginImageContext(andFrame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil}
        
        context.setFillColor(color.cgColor)
        
        context.fill(andFrame)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}
