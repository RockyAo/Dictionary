//
//  UIViewController+Extension.swift
//  BeiJingJiaoJing
//
//  Created by Rocky on 2017/3/30.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController{

    public class func createViewController(fromStoryboardName:String,andIdentifier:String) -> UIViewController?{
        
        let storyBoard = UIStoryboard(name: fromStoryboardName, bundle: Bundle.main)
        
        var vc:UIViewController?
        
        if andIdentifier.characters.count > 0 {
            
            vc = storyBoard.instantiateViewController(withIdentifier: andIdentifier)
        }else{
        
            vc = storyBoard.instantiateInitialViewController()
        }
        
        return vc
    }
    
    
    /// 从storyboard创建控制器(该方法调用需要控制器与storyboard同名),默认在main bundle中寻找
    ///
    /// - Parameter identifier: storyboard中的标示
    /// - Returns: controller
    public class func createViewControllerFromStoryboard(identifier:String = "") -> UIViewController? {
        
        return createViewController(fromStoryboardName: NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!,andIdentifier: identifier)
    }
    
    
}

///progress view
extension UIViewController{
    
    final func showHUD(withStatus:String = ""){
    
        SVProgressHUD.show(withStatus: withStatus)
    }
    
    final func hideHUD(withDlay:TimeInterval = 0){
    
        if SVProgressHUD.isVisible() == true {
            
            SVProgressHUD.dismiss(withDelay: withDlay)
        }
    }
    
    final func showSuccess(withStatus:String = ""){
        
        SVProgressHUD.showSuccess(withStatus: withStatus)
        SVProgressHUD.dismiss(withDelay: 1)
    }
    
    final func showError(withStatus:String){
    
        SVProgressHUD.showError(withStatus: withStatus)
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    final func showProgress(_ progress:Float,andStatus:String = ""){
    
        SVProgressHUD.showProgress(progress, status: andStatus)
    }
}
