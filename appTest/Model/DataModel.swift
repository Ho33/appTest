//
//  DataModel.swift
//  appTest
//
//  Created by hh3 on 9/29/20.
//

import Foundation

struct DataModel : Identifiable , Encodable {
        
    var id : String
    var email : String?
    var exerciseData : [ExerciseModel]
    var title : String
    var text : String
}
