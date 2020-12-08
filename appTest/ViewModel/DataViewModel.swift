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
import FirebaseFirestoreSwift

class DataViewModel: ObservableObject {
    
    
    @Published var error : Error? = nil
    @Published var saved : Bool = false
    @Published var isEdited : Bool = false
    @Published var data = [DataModel]()
    @Published var trainingsDone = [DataModel]()
    @State private var user = UserDefaults.standard.string(forKey: "userUid")
    
    private let db = Firestore.firestore()
    
    init() {
        self.fetchDataUnDone(collectionPath: "trainings")
        self.fetchDataUnDone(collectionPath: "trainingsDone")
    }
    
    func saveData (title: String, exercise: [ExerciseModel], text: String){
        let data : DataModel = DataModel.init(exerciseData: exercise, title: title, text: text)
        do {
            let _ = try db.collection("users").document(self.user!).collection("trainings").addDocument(from: data)
            self.saved = true
        }
        catch {
            self.error = error
        }
    }

    func fetchDataUnDone(collectionPath : String) {
        db.collection("users").document(self.user!).collection(collectionPath).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            if collectionPath == "trainings"{
                self.data = documents.compactMap { queryDocumentSnapshot -> DataModel? in
                    return try? queryDocumentSnapshot.data(as: DataModel.self)
                }
            }else{
                self.trainingsDone = documents.compactMap { queryDocumentSnapshot -> DataModel? in
                    return try? queryDocumentSnapshot.data(as: DataModel.self)
                }
            }
        }}

     func deleteSelected(index: IndexSet) {
        let id = self.data[index.first!].id
        do {
            let _ = try db.collection("users").document(self.user!).collection("trainingsDone").addDocument(from: self.data[index.first!])
        }
        catch {
            self.error = error
        }
        db.collection("users").document(self.user!).collection("trainings").document(id!).delete()
        self.data.remove(atOffsets: index)
    }
    
    func editSelected(item:DataModel, title:String, name:String, text:String){
        let data : [String : Any] = ["title" : title, "text": text]
        db.collection("users").document(self.user!).collection("trainings").document(item.id!).updateData(data) {(error) in
            if let error = error {
                self.error = error
            }else{
                self.isEdited = true
            }
        }
    }
}
