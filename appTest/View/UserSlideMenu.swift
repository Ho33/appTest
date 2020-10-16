//
//  UserDetailsView.swift
//  appTest
//
//  Created by hh3 on 10/9/20.
//

import SwiftUI

struct UserSlideMenu: View {
    
   @ObservedObject private var registrationVM = RegistrationViewModel()
    
    @Binding var login : Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("")
                .resizable()
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 1))
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            Text("user name")
                .font(.largeTitle)
            Divider()
            Group{
                Button(action: {
                    
                }){
                    SingleSlideButtonView(buttonName: "Profile", image: "person.crop.circle", bColor: .black)
                }
                Button(action: {
                    
                }){
                    SingleSlideButtonView(buttonName: "Training History", image: "bolt.heart", bColor: .black)
                }
                Button(action: {
                    
                }){
                    SingleSlideButtonView(buttonName: "Schedoule", image: "calendar.badge.clock", bColor: .black)
                }
                Button(action: {
                    
                }){
                    SingleSlideButtonView(buttonName: "Setting", image: "gear", bColor: .black)
                }
            }
            Spacer()
            Button(action: {
                registrationVM.signOut()
            }){
                SingleSlideButtonView(buttonName: "Sign Out", image: "arrowshape.turn.up.left.circle", bColor: .black)
            }
            .padding(.bottom,25)
        }.onReceive(self.registrationVM.$alreadySignIn, perform: { value in
            if value {
                self.login = false
            }
        })
            
           .padding(EdgeInsets(top: 45, leading: 20, bottom: 0, trailing: 0))
           .frame(width: UIScreen.main.bounds.width / 1.5)
           .background(Color.white)
           .edgesIgnoringSafeArea(.all)
           .overlay(Rectangle().stroke(Color.primary.opacity(0.2),lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(.all))
           
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSlideMenu(login: .constant(false))
    }
}
