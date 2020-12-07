//
//  UserDetailsView.swift
//  appTest
//
//  Created by hh3 on 10/9/20.
//

import SwiftUI

struct UserSlideMenu: View {
    
    @EnvironmentObject var session : SessionStore
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    @ObservedObject private var indexButton = SilderButtonViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("")
                .resizable()
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 1))
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            Text(session.user?.email ?? "")
                .font(.largeTitle)
            Divider()
            Group{
                Button(action: {
                    changueCurrentButton(index: 0)
                }){
                    if indexButton.currentButton == 0{
                        SingleSlideButtonView(buttonName: "Home", image: "house", bColor: .black, selectedButtonColor: .blue)
                    }else {
                        SingleSlideButtonView(buttonName: "Home", image: "house", bColor: .black)
                    }
                }
                Button(action: {
                    changueCurrentButton(index: 1)
                }){
                    if indexButton.currentButton == 1{
                        SingleSlideButtonView(buttonName: "Profile", image: "person.crop.circle", bColor: .black, selectedButtonColor: .blue)
                    }else {
                        SingleSlideButtonView(buttonName: "Profile", image: "person.crop.circle", bColor: .black)
                    }
                }
                Button(action: {
                    changueCurrentButton(index: 2)
                }){
                    if indexButton.currentButton == 2{
                        SingleSlideButtonView(buttonName: "Training History", image: "bolt.heart", bColor: .black, selectedButtonColor: .blue)
                    }else {
                        SingleSlideButtonView(buttonName: "Training History", image: "bolt.heart", bColor: .black)
                    }
                }
                Button(action: {
                    changueCurrentButton(index: 3)
                }){
                    if indexButton.currentButton == 3{
                        SingleSlideButtonView(buttonName: "Schedoule", image: "calendar.badge.clock", bColor: .black, selectedButtonColor: .blue)
                    }else {
                        SingleSlideButtonView(buttonName: "Schedoule", image: "calendar.badge.clock", bColor: .black)
                    }
                }
                Button(action: {
                    changueCurrentButton(index: 4)
                }){
                    if indexButton.currentButton == 4{
                        SingleSlideButtonView(buttonName: "Setting", image: "gear", bColor: .black, selectedButtonColor: .blue)
                    }else {
                        SingleSlideButtonView(buttonName: "Setting", image: "gear", bColor: .black)
                    }
                }
            }
            
            Spacer()
            Divider()
            Button(action: {
                registrationVM.signOut()
            }){
                SingleSlideButtonView(buttonName: "Sign Out", image: "arrowshape.turn.up.left.circle", bColor: .black)
            }
            .padding(.bottom,40)
        }
           .padding(EdgeInsets(top: 45, leading: 20, bottom: 0, trailing: 0))
           .frame(width: UIScreen.main.bounds.width / 1.5)
           .background(Color.white)
           .edgesIgnoringSafeArea(.all)
           .overlay(Rectangle().stroke(Color.primary.opacity(0.2),lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(.all))
           
    }
    func changueCurrentButton(index : Int) {
        self.indexButton.setIndexCurrentButton(index: index)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSlideMenu()
    }
}
