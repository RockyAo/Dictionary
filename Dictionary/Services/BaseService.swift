//
//  BaseService.swift
//  Dictionary
//
//  Created by Rocky on 2017/6/1.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import NSObject_Rx


class BaseService {
    
    let databaseService = DatabaseService()
    
    final func configureData(data:WordModel,needNewId:Bool = false) -> WordDataModel{
        
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
        if needNewId == true {
            
            dataModel.id = Int(NSDate.timeIntervalSinceReferenceDate)
        }else{
        
            dataModel.id = data.id
        }
        
        for item in explains{
            
            let translationObj = Translation()
            translationObj.string = item
            dataModel.translation.append(translationObj)
        }
        
        return dataModel
    }

}
