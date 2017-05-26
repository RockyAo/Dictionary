//
//  BasicTranslation.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import ObjectMapper

struct BasicTranslation: Mappable{
    
    
    var explains:Array<String>?
    
    var ukPhonetic:String?
    
    var usPhonetic:String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        explains 	<- map["explains"]
        ukPhonetic <- map["uk-phonetic"]
        usPhonetic <- map["us-phonetic"]
    }
}
