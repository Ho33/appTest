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
    
    private let utilities = Utilities()
    private let fireAuth = FirebaseAuth.Auth.auth()
    
    @Published var error : Error? = nil
    @Published var alreadySignIn : Bool = false
    @Published var signUpModal : Bool = false
    @Published var userUid : String = ""
    @Published var user : User?
    
    
    func createUser(email: String, password: String , confirmPassword : String) -> Void{
        if password.elementsEqual(confirmPassword) {
            self.fireAuth.createUser(withEmail: email, password: password) { (user, error : Error?) in
                if let error = error{
                    self.error = error
                }else{
                    self.userStatus()
                }
            }
        }
    }
    
    func singIn(email: String, password : String) -> Void{
        self.fireAuth.signIn(withEmail: email, password: password) { (user, error : Error?) in
            if let error = error{
                self.error = error
            }else{
                self.userStatus()
            }
        }
    }
    
    func signOut() -> Void {
        try? self.fireAuth.signOut()
        self.userStatus()
        UserDefaults.standard.removeObject(forKey: "loguedIn")
    }
    
    private func userStatus(){
        self.fireAuth.addStateDidChangeListener { auth, user in
          if let user = user {
            self.user = user
            self.alreadySignIn.toggle()
            self.utilities.setSessionStatus(bol: true, name: "loguedIn")
          } else {
            self.alreadySignIn.toggle()
          }
        }
    }
}
