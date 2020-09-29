//
//  DataViewModel.swift
//  appTest
//
//  Created by hh3 on 9/29/20.
//

import Foundation
import Combine
import Firebase

class DataViewModel: ObservableObject {
    
    private var authController = RegistrationViewModel()
    
    @Published var tittle: String = ""
    @Published var name : String = ""
    @Published var body: String = ""
    @Published var textError: String = ""
    @Published var data = [DataModel]()
    
    
    private let db = Firestore.firestore()
    
    init() {
        data.removeAll()
        db.collection("test").addSnapshotListener{ (QuerySnapshot,error) in
            if let error = error {
                self.textError = error.localizedDescription
            }else{
                for doc in QuerySnapshot!.documents{
                    let value = doc.data()
                    let id = doc.documentID
                    let tittle = value["tittle"] as? String ?? "EMPTY"
                    let name = value["name"] as? String ?? "EMPTY"
                    let body = value["body"] as? String ?? "EMPTY"
                    let email = value["email"] as? String ?? "EMPTY"
                    
                    DispatchQueue.main.async {
                        let reg = DataModel(id: id, email: email, title: tittle, name: name, body: body)
                        self.data.append(reg)
                    }
                }
            }
        }
    }
    
     func saveData(){
        
        let data : [String : Any] = ["tittle" : self.tittle, "name": self.name,"email":self.authController.getUserEmail(),"body":self.body]
        db.collection("test").addDocument(data: data) { (error) in
            if let error = error {
                self.textError = error.localizedDescription
            }
        }
    }
    
     func getData(){
        
    }
}
