//
//  DataModel.swift
//  appTest
//
//  Created by hh3 on 9/29/20.
//

import Foundation
import FirebaseFirestoreSwift

struct DataModel : Identifiable , Codable {
        
    @DocumentID var id: String?
    var exerciseData : [ExerciseModel]?
    var title : String?
    var text : String?
    var date : Date = Date()
    
}
