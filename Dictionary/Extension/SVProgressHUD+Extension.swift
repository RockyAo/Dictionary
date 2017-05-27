//
//  SVProgressHUD+Extension.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/27.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift

extension SVProgressHUD{

    func show(messages:String = "")  {
        
        if !SVProgressHUD.isVisible() {
            
            SVProgressHUD.setFont(UIFont.main.titleFont)
            SVProgressHUD.show(withStatus: messages)
            
        }
    }
    
    func hide() {
        
        if SVProgressHUD.isVisible() {
            
            SVProgressHUD.dismiss()
        }
    }
}


