//
//  BIndable.swift
//  HeartMe
//
//  Created by Oran Even tzur on 21/04/2021.
//

import Foundation

class Bindable <T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?){
        self.listener = listener
        listener?(value)
    }
}
