//
//  HomeViewModel.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct HomeViewModel {
    
    let coordinator : SceneCoordinatorType!
    
    init(coordinator:SceneCoordinatorType,service:HomeServices) {
        
        self.coordinator = coordinator
    }

}
