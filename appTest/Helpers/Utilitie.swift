//
//  Utilitie.swift
//  appTest
//
//  Created by hh3 on 9/28/20.
//

import Foundation


struct Utilitie {
    
    func toggleBoolean(toToggle : Bool){
        //todo
    }
    
    func setUserDefault(bol : Bool, name: String){
        return UserDefaults.standard.set(bol, forKey: name)
    }
    
}
