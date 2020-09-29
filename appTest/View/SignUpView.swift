//
//  SignUpView.swift
//  appTest
//
//  Created by hh3 on 9/22/20.
//

import SwiftUI
import Combine


struct SignUpView: View {
    
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    
    @Binding var login : Bool
    
    var body: some View {
        
        VStack {
            Text("REGISTER").font(.system(size: 40)).fontWeight(.ultraLight).padding().frame(width:220 , height:60)
            SingleFormView(fieldName: "Email", fieldValue: self.$registrationVM.email, isProtected: false)
            SingleFormView(fieldName: "Password", fieldValue: self.$registrationVM.password,isProtected: true)
            SingleFormView(fieldName: "Confirm Password", fieldValue:  self.$registrationVM.confirmPassword, isProtected: true)
            Button(action: { self.registrationVM.createUser()
                if self.registrationVM.getCurrentUser() != nil {
                    self.login.toggle()
                }
            }) {
                Text("SIGN IN")
                    .frame(width: 250 , height: 55)
                    .foregroundColor(Color.white).background(Color.gray)
                    .cornerRadius(30.0)	
            }
            .padding()
            .animation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0.1))
            Spacer()
            
        }.padding(.vertical, 300)
        .alert(isPresented: self.$registrationVM.hasError) {
            Alert(title: Text("ERROR") , message: Text(self.registrationVM.textError), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(login: .constant(false))
    }
}
