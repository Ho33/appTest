//
//  SettingsViewModel.swift
//  appTest
//
//  Created by hh3 on 12/9/20.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestoreSwift

class SettingsViewModel : ObservableObject {
    
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var isPassword : String = ""
    @Published var error : Error?
    @Published var passwordSuccess : String = ""
    @Published var emailSuccess : String = ""
    
    private let currentUser = Firebase.Auth.auth().currentUser
    
    func changueEmail(){
        self.currentUser?.updateEmail(to: self.email) {(error) in
            if let error = error {
                self.error = error
                self.email = ""
            }else {
                self.emailSuccess = "Email made successfully"
                self.email = ""
            }
        }
    }
    
    func changuePassword(){
        if self.password == self.isPassword{
            self.currentUser?.updatePassword(to: self.password) {(error) in
                if let error = error {
                    self.error = error
                    self.password = ""
                    self.isPassword = ""
                } else {
                    self.passwordSuccess = "Password changue successfully"
                    self.password = ""
                    self.isPassword = ""
                }
            }
        }
    }
}
