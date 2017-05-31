//
// Created by Rocky on 2017/5/25.
// Copyright (c) 2017 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation
import RxRealm
import RealmSwift
import NSObject_Rx

class HomeServices{
    
    var player:AVPlayer?
    
    let databaseService = DatabaseService()
    
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
            .map { dataArray in
                
                var finalArray:Array<WordModel> = []
    
                for item in dataArray{
                    var wordModel = WordModel()
                    wordModel.query = item.name
                    wordModel.tSpeakUrl = item.toSpeakUrl
                    wordModel.fSpeakUrl = item.fromSpeakUrl
                    wordModel.selected = item.collection
                    if item.translation.count > 0{
                    
                        var array:Array<String> = []
                        
                        for trans in item.translation.toArray(){
                            array.append(trans.string)
                        }
                        
                        var basicTrans = BasicTranslation()
                        
                        basicTrans.explains = array
                        basicTrans.usPhonetic = item.usPro
                        basicTrans.ukPhonetic = item.ukPro
                        
                        wordModel.basicTranslation = basicTrans
                        
                        finalArray.append(wordModel)
                    }
                }
            
                
                return finalArray
            }
        
    }
    
    func update(item:WordModel) -> Observable<Void>{
        
        let dataModel = configureData(data: item)
        
        databaseService.update(item: dataModel, collection: item.selected)
            .subscribe{
                
                print($0)
            }
        
        return Observable.empty()
    }
    
    fileprivate func configureData(data:WordModel) -> WordDataModel{
    
        ///组装数据
        guard let explains = data.basicTranslation?.explains ,
            let name = data.query,
            let tSpeakUrl = data.tSpeakUrl,
            let fSpeakUrl = data.fSpeakUrl,
            let ukPro = data.basicTranslation?.ukPhonetic,
            let usPro = data.basicTranslation?.usPhonetic
            else{
                
                return WordDataModel()
            }
        
        let dataModel = WordDataModel()
        dataModel.name = name
        dataModel.fromSpeakUrl = fSpeakUrl
        dataModel.toSpeakUrl = tSpeakUrl
        dataModel.ukPro = ukPro
        dataModel.usPro = usPro
        dataModel.collection = data.selected
        
        for item in explains{
            
            let translationObj = Translation()
            translationObj.string = item
            dataModel.translation.append(translationObj)
        }
        
        return dataModel
    }
}


