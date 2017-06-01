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
    func createItem(item: WordDataModel) -> Observable<WordDataModel> {
        
        let result = withRealm("creating") { realm -> Observable<WordDataModel> in
            
            let realm = try Realm()
            let objectArray = realm.objects(WordDataModel.self).toArray()
            
            ///设置主键+1
            item.id = objectArray.count + 1
            
            if objectArray.filter({ (model) -> Bool in
                
                if item.name == model.name{
                    
                    return true
                }
                
                return false
                
            }).count <= 0 {
                try realm.write {
                    
                    realm.add(item)
                }
                return .just(item)
            }
            
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

    
    @discardableResult
    func update(item: WordDataModel, collection: Bool) -> Observable<WordDataModel> {
        
        let result = withRealm("updating collection") { realm -> Observable<WordDataModel> in
            
            let realm = try Realm()
            do{
                
                try realm.write {
                    
                    item.collection = collection
                    
                }
            }catch let error {
            
                print(error)
            }
            return .just(item)
        }
        return result ?? .error(DatabaseError.updateFaild(item))
    }
    
    func items() -> Observable<Results<WordDataModel>> {
        
        let result = withRealm("getting items") { realm -> Observable<Results<WordDataModel>> in
            let realm = try Realm()
            let items = realm.objects(WordDataModel.self)
            return Observable.collection(from: items)
        }
        return result ?? .empty()
    }

}
