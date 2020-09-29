//
//  SignInView.swift
//  appTest
//
//  Created by hh3 on 9/23/20.
//

import SwiftUI
import Combine

struct SignInView: View {
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    
    @Binding var login : Bool
        
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Image("gfi")
                    .resizable()
                    .padding(.horizontal)
                    .padding(.vertical,75)
                    .cornerRadius(30)
                    .frame(width: 300, height: 350, alignment: .center)
                
                Spacer()
                
                VStack {
                    SingleFormView(fieldName: "Email", fieldValue: self.$registrationVM.email, isProtected: false)
                    SingleFormView(fieldName: "Password", fieldValue: self.$registrationVM.password, isProtected: true)
                    Button(action: {
                            self.registrationVM.singIn()
                            if self.registrationVM.getCurrentUser() != nil {
                            self.login.toggle()
                        }
                    }) {
                        Text("LOGIN").frame(width: 350 , height: 55)
                            .foregroundColor(Color.white).background(Color.gray)
                            .cornerRadius(30.0)

                    }.padding()
                    .animation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0.1))
                }
                    Spacer()
                    
                    HStack(spacing: 12){
                        
                        Text("Create an account").foregroundColor(Color.black.opacity(0.6))
                        
                        Button(action: {
                            self.registrationVM.signUpModal.toggle()
                        }){
                            Text("Here!")
                        }.sheet(isPresented: self.$registrationVM.signUpModal) {
                            SignUpView(login: self.$login)
                        }
                        
                    }.padding(.bottom,200)
                    
                }.padding()
            .alert(isPresented: self.$registrationVM.hasError) {
                        Alert(title: Text("ERROR") , message: Text(self.registrationVM.textError) , dismissButton: .default(Text("OK")))
            }
                Spacer(minLength: 0 )
        }
    }
}
    

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(login: .constant(false))
    }
}
