//
//  Scheduler+Rx.swift
//  RxConveninceTool
//
//  Created by Rocky on 2017/5/20.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public enum RAScheduler{

    case Main
    case Serial(DispatchQoS)
    case Concurrent(DispatchQoS)
    case Operation(OperationQueue)
    
    
    public func scheduler() -> ImmediateSchedulerType{
    
        switch self {
        case .Main:
            return MainScheduler.instance
        case .Serial(let QOS):
            return SerialDispatchQueueScheduler(qos: QOS)
        case .Concurrent(let QOS):
            return ConcurrentDispatchQueueScheduler(qos: QOS)
        case .Operation(let queue):
            return OperationQueueScheduler(operationQueue: queue)
        }
    }
}

extension ObservableType{


    public func observeOn(scheduler:RAScheduler) -> Observable<Self.E>{
    
        return observeOn(scheduler.scheduler())
    }
}
