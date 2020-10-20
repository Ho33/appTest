//
//  SignUpView.swift
//  appTest
//
//  Created by hh3 on 9/22/20.
//

import SwiftUI


struct SignUpView: View {
    
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    @State private var errorAlert : (Bool, String) = (show: false, text: "")
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            Text("REGISTER").font(.system(size: 40)).fontWeight(.ultraLight).padding().frame(width:220 , height:60)
            SingleFormView(fieldName: "Email", fieldValue: self.$email, isProtected: false)
            SingleFormView(fieldName: "Password", fieldValue: self.$password,isProtected: true)
            SingleFormView(fieldName: "Confirm Password", fieldValue:  self.$confirmPassword, isProtected: true)
            Button(action: {
                self.registrationVM.createUser(email: self.email, password: self.password, confirmPassword: self.confirmPassword)
            }) {
                Text("SIGN IN")
                    .frame(width: 250 , height: 55)
                    .foregroundColor(Color.white).background(Color.gray)
                    .cornerRadius(30.0)	
            }
            .padding()
            .animation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0.1))
            .padding(.top,30)
            Spacer()
        }
        .padding(.vertical, 170)
        .alert(isPresented: self.$errorAlert.0) {
            Alert(title: Text("ERROR") , message: Text(self.errorAlert.1), dismissButton: .default(Text("OK")))
            
        }
        .onReceive(self.registrationVM.$error, perform: { value in
            if let error = value{
                self.errorAlert.0.toggle()
                self.errorAlert.1 = error.localizedDescription
            }
        })
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
