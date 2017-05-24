//
//  HomeViewController.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initializeCoordinator()
        
        
    }

    
    func bindViewModel() {
        
        
    }

}

extension HomeViewController{

    fileprivate func initializeCoordinator(){
    
        let coordinator = SceneCoordinator(currentViewController: self)
        
        viewModel = HomeViewModel(coordinator: coordinator)
    }
    
}
