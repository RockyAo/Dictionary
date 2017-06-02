//
//  DatabaseServiceType.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/29.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import RealmSwift

enum DatabaseError : Error{
    case creationFaild
    case updateFaild(WordDataModel)
    case deletionFailed(WordDataModel)
    case collectionFailed(WordDataModel)
    case deletionAllFailed
}

protocol DatabaseServiceType {
    
    
    @discardableResult
    func createAndUpdateItem(item:WordDataModel) -> Observable<WordDataModel>
    
    @discardableResult
    func delete(item:WordDataModel) -> Observable<Void>
    
    @discardableResult
    func update(item:WordDataModel,collection:Bool) -> Observable<WordDataModel>
    
    @discardableResult
    func deleteAll() -> Observable<Void>
    
    func items() -> Observable<Results<WordDataModel>>

}
