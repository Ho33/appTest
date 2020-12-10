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
   
    func getGroupImage(type: String) -> String {
        switch type {
            case "Arms":
                return "brazo"
            case "Legs":
                return "piernas"
            case "Back":
                return "espalda"
            case "Chest":
                return "pecho"
            case "Shoulders":
                return "hombros"
            default:
                return ""
        }
    }
}
