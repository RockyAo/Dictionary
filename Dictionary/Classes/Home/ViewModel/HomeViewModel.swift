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
import Action

struct HomeViewModel {
    
    let coordinator : SceneCoordinatorType!
    
    let service : HomeServices!
    
    let disposeBag = DisposeBag()
    
    /// input:
    let searchText:Variable<String> = Variable("")
    
    let playAudioAction:Action<String,Void>
    
    ///output
    var translateData:Driver<WordModel>

    
    init(coordinator:SceneCoordinatorType,service:HomeServices) {
        
        self.coordinator = coordinator
        
        self.service = service
        
        translateData = searchText.asDriver()
            .skip(1)
            .flatMap{

                return service.requestData(string: $0).asDriver(onErrorJustReturn: WordModel())
            }
        
        playAudioAction = Action{ input in
        
            print(input)
            
            return service.playAudio(urlString: input)
        }
    }
    
    
    
}
