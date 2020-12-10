//
//  HomePage.swift
//  appTest
//
//  Created by hh3 on 9/23/20.
//

import SwiftUI
import Firebase

struct SliderSelectedButtonView: View {
        
    @ObservedObject private var indexButton = SilderButtonViewModel.shared
    
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
                    
                    self.getView()
                        .allowsHitTesting(disableView)
                        .navigationBarItems(leading: Button(action: {
                            self.disableView = false
                            self.offset = self.openOffset
                        }){
                            Image(systemName: "list.bullet")
                        })
                        .edgesIgnoringSafeArea(.top)
                }.onReceive(self.indexButton.$currentButton){ value in
                    self.currentButton = value
                    setSliderMenuClosed(geometry: geometry)
                }
                Spacer()
            
            // Slide menu
            UserSlideMenu()
                .onAppear(perform: {
                    setSliderMenuClosed(geometry: geometry)
                })
                .offset(x: self.offset)
                .animation(.default)
                .gesture(DragGesture(minimumDistance: 5)
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
//        .gesture(DragGesture(minimumDistance: 5)
//                    .onChanged{ value in
//                        if (self.offset < self.openOffset) {
//                            self.disableView = false
//                            self.offset = self.closeOffset + value.translation.width
//                        }
//                    }
//                    .onEnded { value in
//                        if (value.location.x > value.startLocation.x) {
//                            self.disableView = false
//                            self.offset = self.openOffset
//                        } else {
//                            self.disableView = true
//                            self.offset = self.closeOffset
//                        }
//                    }
//        )
    }
    fileprivate func setSliderMenuClosed(geometry: GeometryProxy) {
        self.offset = geometry.size.width * -1
        self.closeOffset = self.offset
        self.openOffset = .zero
        self.disableView = true
   }
    
    func getView() -> AnyView {
        switch self.currentButton {
            case 0:
                return AnyView(HomeView())
            case 1:
                return AnyView(ProfileView())
            case 2:
                return AnyView(HistoryView())
            case 3:
                return AnyView(SchedouleView())
            case 4:
                return AnyView(SettingsView())
            default:
                return AnyView(HomeView())
        }
    }
}




struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        SliderSelectedButtonView()
    }
}
