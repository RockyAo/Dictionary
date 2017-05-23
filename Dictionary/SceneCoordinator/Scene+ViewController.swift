//
//  Scene+ViewController.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import UIKit

extension Scene{
    func viewController() -> UIViewController{
        
        switch self {
        case .Home:
            let homeVc = HomeViewController()
            return homeVc
        case .Book:
            let bookVc = BookViewController()
            return bookVc
        case .Setting:
            let settingVc = SettingViewController()
            
            return settingVc
        }
    }
}
