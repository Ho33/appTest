//
//  UserModel.swift
//  appTest
//
//  Created by hh3 on 12/9/20.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel : Identifiable , Codable , Hashable {
        
    @DocumentID var id: String?
    var name : String?
    var surname : String?
    var age : String?
    var phone : String?
    var address : String?
    var weight : String?
    var height : String?
}
