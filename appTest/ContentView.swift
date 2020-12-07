//
//  ContentView.swift
//  appTest
//
//  Created by hh3 on 9/22/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        Group{
            if session.user != nil {
                SliderSelectedButtonView()
                
            } else {
                SignInView()
            }
        }.onAppear(
            perform: {
                userState()
                
            }
        )
    }
    
    func userState () {
        session.listen()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
