//
//  ProfileViewModel.swift
//  appTest
//
//  Created by hh3 on 12/9/20.
//

import Combine
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

class ProfileViewModel : ObservableObject {
    
    @Published var userData : UserModel = UserModel.init()
    @Published var name : String = ""
    @Published var surname : String = ""
    @Published var age : String = ""
    @Published var phone : String = ""
    @Published var address : String = ""
    @Published var weight : String = ""
    @Published var height : String = ""
    @Published var error : Error? = nil
    
    @State private var user = UserDefaults.standard.string(forKey: "userUid")
    private let db = Firestore.firestore()
    
    init(){
        self.getUserData()
    }
       
    
    func getUserData(){
        db.collection("users").document(self.user!).getDocument{ (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.userData.name = dataDescription?["name"] as? String
                self.userData.surname = dataDescription?["surname"] as? String
                self.userData.age = dataDescription?["age"] as? String
                self.userData.phone = dataDescription?["phone"] as? String
                self.userData.address = dataDescription?["address"] as? String
                self.userData.weight = dataDescription?["weight"] as? String
                self.userData.height = dataDescription?["height"] as? String
                
                self.name = (dataDescription?["name"] as? String)!
                self.surname = (dataDescription?["surname"] as? String)!
                self.age = (dataDescription?["age"] as? String)!
                self.phone = (dataDescription?["phone"] as? String)!
                self.address = (dataDescription?["address"] as? String)!
                self.weight = (dataDescription?["weight"] as? String)!
                self.height = (dataDescription?["height"] as? String)!
                
            } else {
                self.error = error
            }
        }
    }
    
    
    func saveUserData(){
        let campos : [String:Any] =
            ["name" : self.name ,"surname": self.surname, "age" : self.age, "phone" : self.phone, "address" : self.address, "weight" : self.weight , "height" : self.height]
        self.db.collection("users").document(self.user!).setData(campos)
        self.getUserData()
    }
}
    
