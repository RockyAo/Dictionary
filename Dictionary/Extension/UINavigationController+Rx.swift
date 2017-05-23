//
//  UINavigationController+Rx.swift
//  RxConveninceTool
//
//  Created by Rocky on 2017/5/20.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RxNavigationControllerDelegateProxy: DelegateProxy, DelegateProxyType, UINavigationControllerDelegate {
    
    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        guard let navigationController = object as? UINavigationController else {
            fatalError()
        }
        return navigationController.delegate
    }
    
    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        guard let navigationController = object as? UINavigationController else {
            fatalError()
        }
        if delegate == nil {
            navigationController.delegate = nil
        } else {
            guard let delegate = delegate as? UINavigationControllerDelegate else {
                fatalError()
            }
            navigationController.delegate = delegate
        }
    }
}

extension Reactive where Base: UINavigationController {
    
    public var delegate: DelegateProxy {
        return RxNavigationControllerDelegateProxy.proxyForObject(base)
    }
}
