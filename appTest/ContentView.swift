//
//  ContentView.swift
//  appTest
//
//  Created by hh3 on 9/22/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var login = false
    
    var body: some View {
        
        return Group{
            if self.login {
                HomePage(login: self.$login)
            } else {
                SignInView(login: self.$login)
            }
        }.onAppear{
            if UserDefaults.standard.object(forKey: "loguedIn") != nil{
                self.login = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
