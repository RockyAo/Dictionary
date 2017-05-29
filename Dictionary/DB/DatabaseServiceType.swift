//
//  DatabaseServiceType.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/29.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxSwift

enum DatabaseError {
    case creationFaild
    case updateFaild()
    case deletionFailed()
    case collectionFailed()
}

protocol DatabaseServiceType {
    
    
    @discardableResult
    func createTask(item:WordDataModel) -> Observable<WordDataModel>
    
    @discardableResult
    func delete(task:WordDataModel) -> Observable<Void>
    
    @discardableResult
    func update(task:WordDataModel) -> Observable<WordDataModel>
    
    @discardableResult
    func collection(task:WordDataModel) -> Observable<WordDataModel>
    
    func tasks() -> Observable<WordDataModel>

}
