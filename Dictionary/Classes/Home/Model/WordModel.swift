//
//  WordModel.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import ObjectMapper

struct WordModel:Mappable {
    
    var query:String?
    
    var speakUrl:String?
    
    var basicTranslation:BasicTranslation?
    
    var translation:Array<String>?
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    init?(map: Map) {
        
    }
    
    init() {
        
    }

    mutating func mapping(map: Map) {
        query 	<- map["query"]
        speakUrl 	<- map["tSpeakUrl"]
        basicTranslation <- map["basic"]
        translation <- map["translation"]
    }
    
}
