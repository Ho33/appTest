//
//  SignInView.swift
//  appTest
//
//  Created by hh3 on 9/23/20.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var errorAlert : (Bool, String) = (false,"")
    
    @State var showModal : Bool = false
    
    @Binding  var login : Bool
    
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
                    SingleFormView(fieldName: "Email", fieldValue: self.$email, isProtected: false)
                    SingleFormView(fieldName: "Password", fieldValue: self.$password, isProtected: true)
                    Button(action: {
                        self.registrationVM.singIn(email: self.email,password: self.password)
                        
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
                            self.showModal.toggle()
                        }){
                            Text("Here!")
                        }.sheet(isPresented: self.$showModal) {
                            SignUpView(login: self.$login)
                        }
                        
                    }.padding(.bottom,200)
                    
            }.padding()
            .alert(isPresented: self.$errorAlert.0) {
                Alert(title: Text("ERROR") , message: Text(self.errorAlert.1), dismissButton: .default(Text("OK")))
            
            }
            .onReceive(self.registrationVM.$error, perform: { value in
                if let error = value{
                    self.errorAlert.0.toggle()
                    self.errorAlert.1 = error.localizedDescription
                }
            })
            .onReceive(self.registrationVM.$alreadySignIn, perform: { value in
                if value {
                    self.showModal = false
                    self.login = true
                }
            })
        }
    }
}



struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(login: .constant(false))
    }
}
