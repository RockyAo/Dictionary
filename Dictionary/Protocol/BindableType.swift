//
//  BindableType.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import ESTabBarController_swift

protocol BindableType {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
    
}

extension BindableType where Self:UIViewController{
    
    mutating func bindViewModel(to model: Self.ViewModelType){
        
        viewModel = model
        
        loadViewIfNeeded()
        
        bindViewModel()
    }
}

