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
    
    
    @Published var error : Error? = nil
    @Published var saved : Bool = false
    @Published var data = [DataModel]()
    
    
    private let db = Firestore.firestore()
    
    init() {
        data.removeAll()
        db.collection("test").addSnapshotListener{ (QuerySnapshot,error) in
            if let error = error {
                self.error = error
            }else{
                for doc in QuerySnapshot!.documents{
                    let value = doc.data()
                    let id = doc.documentID
                    let tittle = value["title"] as? String ?? "EMPTY"
                    let name = value["name"] as? String ?? "EMPTY"
                    let body = value["body"] as? String ?? "EMPTY"
                    let email = value["uid"] as? String ?? "EMPTY"
                    
                    DispatchQueue.main.async {
                        let reg = DataModel(id: id, email: email, title: tittle, name: name, body: body)
                        self.data.append(reg)
                    }
                }
            }
        }
    }
    
    func saveData(title : String,name: String, text: String){
        let data : [String : Any] = ["title" : title, "name": name, "body": text]
        db.collection("test").addDocument(data: data) { (error) in
            if let error = error {
                self.error = error
            }else{
                self.saved.toggle()
            }
        }
    }
}
