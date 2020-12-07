//
//  DataViewModel.swift
//  appTest
//
//  Created by hh3 on 9/29/20.
//
import SwiftUI
import Foundation
import Combine
import Firebase

class DataViewModel: ObservableObject {
    
    
    @Published var error : Error? = nil
    @Published var saved : Bool = false
    @Published var isEdited : Bool = false
    @Published var data = [DataModel]()
    @State private var user = UserDefaults.standard.string(forKey: "userUid")
    
    private let db = Firestore.firestore()
    
    init() {
        db.collection("users").document(self.user!).collection("trainings").addSnapshotListener{ (QuerySnapshot,error) in
            if let error = error {
                self.error = error
            }else{
                self.data.removeAll()
                for doc in QuerySnapshot!.documents{
                    let value = doc.data()
                    let id = doc.documentID
                    let tittle = value["title"] as? String ?? "EMPTY"
                    let exercise = value["exercise"] as? [ExerciseModel] ?? []
                    let text = value["text"] as? String ?? "EMPTY"

                    DispatchQueue.main.async {
                        let reg = DataModel(id: id, exerciseData: exercise, title: tittle, text: text)
                        self.data.append(reg)
                    }
                }
            }
        }
    }
    
    func saveData (title: String, exercise: [ExerciseModel], text: String){
        let data : [String : Any] = ["title" : title, "exercise" : exercise, "text": text]
        db.collection("users").document(self.user!).collection("trainings").addDocument(data: data) { (error) in
            if let error = error {
                self.error = error
            }else{
                self.saved = true
            }
        }
    }
    
     func deleteSelected( index: IndexSet) {
        let id = self.data[index.first!].id
        db.collection("users").document(self.user!).collection("trainings").document(id).delete()
        self.data.remove(atOffsets: index)
    }
    
    func editSelected(item:DataModel, title:String, name:String, text:String){
        let data : [String : Any] = ["title" : title, "text": text]
        db.collection("users").document(self.user!).collection("trainings").document(item.id).updateData(data) {(error) in
            if let error = error {
                self.error = error
            }else{
                self.isEdited = true
            }
        }
    }
}
