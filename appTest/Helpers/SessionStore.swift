//
//  SessionStore.swift
//  appTest
//
//  Created by hh3 on 10/20/20.
//

import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var user: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    @State private var utilities : Utilities = Utilities()
    
    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.user = user
                self.utilities.setUser(User: user)
            } else {
                self.user = nil
            }
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
