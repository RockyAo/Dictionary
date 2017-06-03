//
//  Enum.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation

enum DictionaryError: Error{
    
    case mapJsonError
    case netError(discription:String)
    case mapError(desciption:String)
}

enum PlayAudioError:Error {
    case playFaild
}

