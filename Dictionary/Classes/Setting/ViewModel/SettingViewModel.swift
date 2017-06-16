//
//  SettingViewModel.swift
//  Dictionary
//
//  Created by Rocky on 2017/6/16.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

struct SettingViewModel {
    
    let versionDriver:Driver<String>
    
    fileprivate let service = DatabaseService()
    
    init() {
        
        
        versionDriver = Observable.create({ (observer) -> Disposable in
            
            let infoDict = Bundle.main.infoDictionary
            
            guard let versionNo = infoDict?["CFBundleShortVersionString"] else{
                
                fatalError()
            }
            
            let stringNumber = "\(versionNo)"
            
            observer.onNext(stringNumber)
            observer.onCompleted()
            
            return Disposables.create()
        })
        .asDriver(onErrorJustReturn: "")
    }
    
    func clearLocalDataAction()  {
        
       service.deleteAll()
    }
}
