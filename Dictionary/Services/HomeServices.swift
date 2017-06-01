//
// Created by Rocky on 2017/5/25.
// Copyright (c) 2017 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation


class HomeServices:BaseService{
    
    var player:AVPlayer?
    

    func requestData(string:String) -> Observable<WordModel> {
        
        return dictionaryAPI.request(.query(target: string))
            .asObservable()
            .mapJSON()
            .mapToObjectWithNoError(modelTypeL: WordModel.self)
        
    }
    
    
    func playAudio(urlString:String) -> Observable<Void> {
        
        print(urlString)
        
        if let url = URL(string: urlString){
            
            player = AVPlayer(url: url)
            
            player?.play()
        }
        
       
        return Observable.empty()
    }
    
    @discardableResult
    func storageNewWord(item:WordModel) -> Observable<Void> {
        
        let data = configureData(data: item)
        
        if data.translation.toArray().count > 0 {
            
            return databaseService.createItem(item: data).map({ (data) in
                
            })
        }
        
        
        return Observable.create({ (observer) -> Disposable in
            
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    func allHistory() -> Observable<[WordModel]>{
        
        return databaseService.items()
            .map { (result)  in
                
                return result.toArray()
            }
            .mapDataModelArrayToWordModelArray()
    }
    
    func update(item:WordModel) -> Observable<Void>{
        
        let dataModel = configureData(data: item)
        
        databaseService.update(item: dataModel, collection: item.selected)
            .debug()
            .subscribe{
                
                print($0)
            }
        
        return Observable.empty()
    }
    
}


