//
//  ExerciseModel.swift
//  appTest
//
//  Created by hh3 on 12/7/20.
//

import Foundation
import FirebaseFirestoreSwift

struct ExerciseModel : Identifiable , Codable {
    
    @DocumentID var id: String?
    var name : String
    var series : String
    var reps : String
    var text : String
}
