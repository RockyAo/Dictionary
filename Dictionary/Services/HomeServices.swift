//
// Created by Rocky on 2017/5/25.
// Copyright (c) 2017 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation
import RxRealm
import RealmSwift


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
    
    func storageNewWord(item:WordModel) {
        
        ///组装数据
        guard let explains = item.basicTranslation?.explains ,
            let name = item.query,
            let tSpeakUrl = item.tSpeakUrl,
            let fSpeakUrl = item.fSpeakUrl,
            let ukPro = item.basicTranslation?.ukPhonetic,
            let usPro = item.basicTranslation?.usPhonetic
            else{
                
                return
        }
        
        if explains.count > 0{
            
            
            let dataModel = WordDataModel()
            dataModel.name = name
            dataModel.fromSpeakUrl = fSpeakUrl
            dataModel.toSpeakUrl = tSpeakUrl
            dataModel.ukPro = ukPro
            dataModel.usPro = usPro
            for item in explains{
                
                let translationObj = Translation()
                translationObj.string = item
                dataModel.translation.append(translationObj)
            }
            
            databaseService.createItem(item: dataModel)
            
        }
        

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
                    
                    var array:Array<String> = []
                    
                    for trans in item.translation.toArray(){
                        array.append(trans.string)
                    }
                    
                    wordModel.basicTranslation?.explains = array
                    wordModel.basicTranslation?.usPhonetic = item.usPro
                    wordModel.basicTranslation?.ukPhonetic = item.ukPro
                    
                    finalArray.append(wordModel)
                }
                return finalArray
            }
    }
}


