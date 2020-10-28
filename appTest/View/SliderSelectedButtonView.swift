//
//  HomePage.swift
//  appTest
//
//  Created by hh3 on 9/23/20.
//

import SwiftUI
import Firebase

struct SliderSelectedButtonView: View {
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    @ObservedObject private var dataVM = DataViewModel()
    @ObservedObject private var sliderButtonVM = SilderButtonViewModel()
    
    @State private var data = [DataModel]()
    @State private var errorAlert : (Bool,String) = (false,"")
    @State private var show : Bool = false
    @State private var offset = CGFloat.zero
    @State private var closeOffset = CGFloat.zero
    @State private var openOffset = CGFloat.zero
    @State private var disableView = true
    @State private var currentButton : Int = 0
    
    
    var body: some View {
        GeometryReader { geometry in
                NavigationView {
                    HomeView()
                        .allowsHitTesting(disableView)
                        .navigationBarItems(leading: Button(action: {
                            self.disableView = false
                            self.offset = self.openOffset
                        }){
                            Image(systemName: "list.bullet")
                        })
                        .edgesIgnoringSafeArea(.top)
                }.onReceive(sliderButtonVM.$currentButton, perform: { value in
                        
                    })
                Spacer()
            
            // Slide menu
            UserSlideMenu()
                .onAppear(perform: {
                    self.offset = geometry.size.width * -1
                    self.closeOffset = self.offset
                    self.openOffset = .zero
                })
                .offset(x: self.offset)
                .animation(.default)
        }.gesture(DragGesture(minimumDistance: 5)
                    .onChanged{ value in
                        if (self.offset < self.openOffset) {
                            self.disableView = false
                            self.offset = self.closeOffset + value.translation.width
                        }
                    }
                    .onEnded { value in
                        if (value.location.x > value.startLocation.x) {
                            self.disableView = false
                            self.offset = self.openOffset
                        } else {
                            self.disableView = true
                            self.offset = self.closeOffset
                        }
                    }
        )
        
        }
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        SliderSelectedButtonView()
    }
}
