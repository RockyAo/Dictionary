//
//  ReactiveExtension.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/27.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base:UIView{

    var hidden: Observable<Bool> {
        return self.methodInvoked(#selector(setter: self.base.isHidden))
            .map { event -> Bool in
                guard let isHidden = event.first as? Bool else {
                    fatalError()
                }
                
                return isHidden
            }
            .startWith(self.base.isHidden)
    }
}

extension Observable{

    ///转换数据库模型数组 到  单词模型数组
    func mapDataModelArrayToWordModelArray() -> Observable<[WordModel]> {
        
        return self.map({ response in
            
            guard let dataArray = response as? [WordDataModel] else {
                throw DictionaryError.mapError(desciption: "transform model faild")
            }
            
            var finalArray:Array<WordModel> = []
            
            for item in dataArray{
                var wordModel = WordModel()
                wordModel.query = item.name
                wordModel.tSpeakUrl = item.toSpeakUrl
                wordModel.fSpeakUrl = item.fromSpeakUrl
                wordModel.selected = item.collection
                wordModel.id = item.id
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
            
        })
    }
    
    func mapWordDataModelToWordModel() -> Observable<WordModel> {
        return self.map({ (response) in
            
            guard let dataModel = response as? WordDataModel else {
                throw DictionaryError.mapError(desciption: "transform model faild")
            }
            
            var wordModel = WordModel()
            wordModel.query = dataModel.name
            wordModel.tSpeakUrl = dataModel.toSpeakUrl
            wordModel.fSpeakUrl = dataModel.fromSpeakUrl
            wordModel.selected = dataModel.collection
            wordModel.id = dataModel.id
            if dataModel.translation.count > 0{
                
                var array:Array<String> = []
                
                for trans in dataModel.translation.toArray(){
                    array.append(trans.string)
                }
                
                var basicTrans = BasicTranslation()
                
                basicTrans.explains = array
                basicTrans.usPhonetic = dataModel.usPro
                basicTrans.ukPhonetic = dataModel.ukPro
                
                wordModel.basicTranslation = basicTrans
                
            }
            
            return wordModel
        })
    }
}
