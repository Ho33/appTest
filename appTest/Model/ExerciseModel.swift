//
//  ExerciseModel.swift
//  appTest
//
//  Created by hh3 on 12/7/20.
//

import Foundation

struct ExerciseModel : Identifiable , Hashable{
    
    var id = UUID()
    var name : String
    var series : String
    var reps : String
    var text : String
}
