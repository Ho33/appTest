//
//  Utilitie.swift
//  appTest
//
//  Created by hh3 on 9/28/20.
//

import Foundation
import Firebase

struct Utilities {
    
    
    func setSessionStatus(bol : Bool, name: String) -> Void {
        UserDefaults.standard.set(bol, forKey: name)
    }
    func setUser(User: User){
        UserDefaults.standard.setValue(User.uid, forKey: "userUid")
    }
}
