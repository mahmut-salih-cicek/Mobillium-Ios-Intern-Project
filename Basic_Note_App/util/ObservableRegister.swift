//
//  RegisterResponseObject.swift
//  Basic_Note_App
//
//  Created by xmod on 25.07.2022.
//

import Foundation


import Foundation

final class ObservableRegister<T>{
    
    var value : T? {
        didSet{
            listener?(value)
        }
    }
    
    private var listener : ((T?) -> Void)?
    
    init(_ value : T?){
        self.value = value
    }
    
    func bind(_ listener: @escaping(T?) -> Void){
        listener(value)
        self.listener = listener
    }
    
}
