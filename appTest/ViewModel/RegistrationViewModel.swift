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
    
    
    func createUser(email: String, password: String , confirmPassword : String) -> Void{
        if password.elementsEqual(confirmPassword) {
            self.fireAuth.createUser(withEmail: email, password: password) { (user, error : Error?) in
                if let error = error{
                    self.error = error
                }else{
                    print("hola")
                    self.alreadySignIn.toggle()
                    self.utilities.setUserDefault(bol: true, name: "loguedIn")
                }
            }
        }
    }
    
    func singIn(email: String, password : String) -> Void{
        self.fireAuth.signIn(withEmail: email, password: password) { (user, error : Error?) in
            if let error = error{
                self.error = error
            }else{
                self.alreadySignIn.toggle()
                self.utilities.setUserDefault(bol: true, name: "loguedIn")
            }
        }
    }
    
    func signOut() -> Void {
        try? self.fireAuth.signOut()
        self.alreadySignIn.toggle()
        UserDefaults.standard.removeObject(forKey: "loguedIn")
    }
}
