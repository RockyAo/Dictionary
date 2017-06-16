//
//  MainTabbarController.swift
//  BeiJingJiaoJing
//
//  Created by Rocky on 2017/3/7.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import ESTabBarController_swift

final class MainTabbarController: ESTabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addChildViewControllers()
        
        setTabbar()
        
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        
        
        selectedIndex = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        
    
    }
    
    func bindViewModel() {
        
        
    }
}

// MARK: - 设置界面
extension MainTabbarController {
    
    
    fileprivate func setTabbar(){
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 13)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 13)], for: .selected)
        
    }
    
    fileprivate func addChildViewControllers(){
        
        addChildViewController(HomeViewController(), title: "词典", normalImage: #imageLiteral(resourceName: "tabbar_dictionary"), selectedImage: #imageLiteral(resourceName: "tabbar_dictionary_selected"))
        addChildViewController(BookViewController(), title:"单词本", normalImage: #imageLiteral(resourceName: "tabbar_notebook"), selectedImage: #imageLiteral(resourceName: "tabbar_dictionary_selected"))
        addChildViewController(SettingViewController.createViewControllerFromStoryboard()!, title: "设置", normalImage: #imageLiteral(resourceName: "tabbar_setting"), selectedImage: #imageLiteral(resourceName: "tabbar_setting_selected"))

    }
    
    fileprivate func addChildViewController(_ vc: UIViewController, title: String, normalImage: UIImage,selectedImage:UIImage) {
        
        vc.title = title
        
        vc.tabBarItem = ESTabBarItem.init(TabbarItemBounceContentView(), title: title, image:normalImage, selectedImage: selectedImage)
        
        let nav:CustomNavigationController = CustomNavigationController(rootViewController: vc)
        
        
        addChildViewController(nav)
    }
    
}


// MARK: - UITabBarControllerDelegate
extension MainTabbarController:UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        

        return true
    }
//
    
}

