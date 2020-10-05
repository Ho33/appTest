//
//  Utilitie.swift
//  appTest
//
//  Created by hh3 on 9/28/20.
//

import Foundation


struct Utilities {
    
    
    func setUserDefault(bol : Bool, name: String) -> Void {
        UserDefaults.standard.set(bol, forKey: name)
    }
}
