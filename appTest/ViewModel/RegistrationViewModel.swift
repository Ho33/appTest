//
//  LoginData.swift
//  appTest
//
//  Created by hh3 on 9/22/20.
//

import Foundation
import Combine
import Firebase

class RegistrationViewModel : ObservableObject {
    
    private let utilitie = Utilitie()
    private let fireAuth = FirebaseAuth.Auth.auth()
    
    
    @Published var email: String = ""
    @Published var password : String = ""
    @Published var confirmPassword:String = ""
    @Published var textError : String = ""
    @Published var hasError: Bool = false
    @Published var alreadySignIn : Bool = false
    @Published var signUpModal : Bool = false
    
    
    
    
    func createUser(){
        self.toogleError()
        if self.password.elementsEqual(self.confirmPassword) {
            self.fireAuth.createUser(withEmail: self.email, password: self.password) { (user, error : Error?) in
                if let error = error {
                    self.setError(error: error)
                }
                self.utilitie.setUserDefault(bol: true, name: "loguedIn")
            }
        }else{
            self.textError = "Password dont match"
        }
    }
    
    func singIn() {
        self.toogleError()
        self.fireAuth.signIn(withEmail: self.email, password: self.password) { (user, error : Error?) in
            if let error = error{
                self.setError(error: error)
            }else{
                self.utilitie.setUserDefault(bol: true, name: "loguedIn")
            }
        }
    }
    
    func getCurrentUser() -> User? {
        return self.fireAuth.currentUser
    }
    
     func signOut() {
        try? self.fireAuth.signOut()
        UserDefaults.standard.removeObject(forKey: "loguedIn")
    }
    
    func getUserEmail() -> String {
        return self.fireAuth.currentUser!.email!
    }
    
    private func toogleError () {
        if self.hasError {
            self.hasError.toggle()
        }
    }
    
    private func setError(error: Error){
        self.textError = error.localizedDescription
        self.hasError.toggle()
    }
}
