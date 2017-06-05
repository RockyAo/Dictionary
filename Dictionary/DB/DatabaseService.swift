//
//  DatabaseService.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/29.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

class DatabaseService:DatabaseServiceType{
    

    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            let realm = try Realm()
            
            return try action(realm)
        } catch let err {
            print("Failed \(operation) realm with error: \(err)")
            return nil
        }
    }
    
    
    /// 入库并自动过滤已存在数据
    ///
    /// - Parameter item: Realm模型
    /// - Returns: Observable<>
    @discardableResult
    func createAndUpdateItem(item: WordDataModel) -> Observable<WordDataModel>{
        
       let result = withRealm("create item") { (realm) -> Observable<WordDataModel> in
        
            let realm = try! Realm()
        
            _ = Observable.just(item)
                .subscribe(realm.rx.add(update: true))
        
            return .just(item)
       }
        
       return result ?? .error(DatabaseError.creationFaild)
    }
    
    @discardableResult
    func delete(item: WordDataModel) -> Observable<Void> {
        
        let result = withRealm("deleting") { realm-> Observable<Void> in
            try realm.write {
                realm.delete(item)
            }
            return .empty()
        }
        return result ?? .error(DatabaseError.deletionFailed(item))
    }
    
    @discardableResult
    func deleteAll() -> Observable<Void> {
        let result = withRealm("deleting") { realm-> Observable<Void> in
            try realm.write {
                realm.deleteAll()
            }
            return .empty()
        }
        return result ?? .error(DatabaseError.deletionAllFailed)
    }

    
    func items() -> Observable<Results<WordDataModel>> {
        
        let result = withRealm("getting items") { realm -> Observable<Results<WordDataModel>> in
            let realm = try Realm()
            let items = realm.objects(WordDataModel.self)
            return Observable.collection(from: items)   
        }
        return result ?? .empty()
    }
    
    func selectedItems() -> Observable<Array<WordDataModel>> {
        
        let result =  withRealm("getting selected items") { (realm) -> Observable<Array<WordDataModel>> in
            
            let relam = try Realm()
            
            let items = relam.objects(WordDataModel.self)
                        .toArray()
                        .filter({ (dataModel) -> Bool in
                            return dataModel.collection
                        })
            
            return .just(items)
        }
        
        return result ?? .empty()
    }

}
