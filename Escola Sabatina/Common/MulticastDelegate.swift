//
//  MulticastDelegate.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 06/07/23.
//

import Foundation

class MulticastDelegate<T> {
    
    private class Wrapper {
        weak var delegate: AnyObject?
        
        init(_ delegate: AnyObject) {
            self.delegate = delegate
        }
    }
    
    private var wrappers: [Wrapper] = []
    public var delegates: [T] {
        return wrappers.compactMap { $0.delegate } as! [T]
    }
    
    func add(delegate: T) {
        let wrapper = Wrapper(delegate as AnyObject)
        wrappers.append(wrapper)
    }
    
    func add(delegates: [T]) {
        delegates.forEach { delegate in
            let wrapper = Wrapper(delegate as AnyObject)
            wrappers.append(wrapper)
        }
    }
    
    func remove(delegate: T) {
        guard let index = wrappers.firstIndex(where: { $0.delegate === delegate as AnyObject }) else {
            return
        }
        
        wrappers.remove(at: index)
    }
    
    func invokeForEachDelegate(_ handler: (T) -> ()) {
        delegates.forEach { handler($0) }
    }
}
