//
//  WordDataModel.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/29.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RealmSwift

class WordDataModel: Object {
    
    dynamic var name:String = ""
    
    dynamic var ukPro:String = ""
    
    dynamic var usPro:String = ""
    
    dynamic var toSpeakUrl:String = ""
    
    dynamic var fromSpeakUrl:String = ""
    
    dynamic var collection:Bool = false
    
    dynamic var id:Int = 0
    
    var translation:List<Translation> = List<Translation>()
    
    override class func primaryKey() -> String? {

        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["name"]
    }

}
