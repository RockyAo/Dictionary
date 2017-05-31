//
//  WordModel.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct WordModel:Mappable{
    
    var query:String? 
    
    var tSpeakUrl:String?
    
    var fSpeakUrl:String?
    
    
    var basicTranslation:BasicTranslation?
    
    var translation:Array<String>?
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    
    var finalUrl:String?{
        
        guard let string = self.query else { return ""}
        
        if string.hasChinese {
            
            return self.tSpeakUrl
        }else{
        
            return self.fSpeakUrl
        }
    }
    
    init?(map: Map) {
        
    }
    
    init() {
        
    }

    mutating func mapping(map: Map) {
        query 	<- map["query"]
        tSpeakUrl 	<- map["tSpeakUrl"]
        basicTranslation <- map["basic"]
        translation <- map["translation"]
        fSpeakUrl <- map["speakUrl"]
    }
    
    
}

extension WordModel: IdentifiableType,Equatable{
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: WordModel, rhs: WordModel) -> Bool {
        
        return lhs.query != rhs.query
    }

    
    var identity:Int{
        
        return Int(arc4random_uniform(10000000))
    }
}



