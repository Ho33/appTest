//
//  SettingsView.swift
//  appTest
//
//  Created by hh3 on 10/28/20.
//

import SwiftUI
import Combine

struct SettingsView: View {
    
    @ObservedObject var settingsVM : SettingsViewModel = SettingsViewModel()
    @State private var errorAlert : (Bool, String) = (show: false, text: "")
    @State private var passwordChangued : String = ""
    @State private var emailChangued : String = ""

    var body: some View {
        VStack {
            VStack{
                Text("CHANGUE PASSWORD").font(.headline)
        SingleFormView(fieldName: "New password", fieldValue: self.$settingsVM.password, isProtected: true)
        SingleFormView(fieldName: "Repeat Password", fieldValue: self.$settingsVM.isPassword, isProtected: true)
            }
            Text(self.passwordChangued)
                .foregroundColor(.red)
        Button(action: {
            self.settingsVM.changuePassword()
        }, label: {
            Text("Update password")
        })
            .padding()
        .border(Color.black)
            VStack{
            Text("CHANGUE EMAIL").font(.headline)
        SingleFormView(fieldName: "Update email", fieldValue: self.$settingsVM.email, isProtected: false)
            Text(self.emailChangued)
                .foregroundColor(.red)
        Button(action: {
            self.settingsVM.changueEmail()
        }, label: {
            Text("Update email")
        }).padding()
        .border(Color.black)
            }.padding()
            Spacer()
        }.padding(.top, 100)
        
        .alert(isPresented: self.$errorAlert.0) {
            Alert(title: Text("ERROR") , message: Text(self.errorAlert.1), dismissButton: .default(Text("OK")))

        }
        .onReceive(self.settingsVM.$error, perform: { value in
            if let error = value{
                self.errorAlert.0.toggle()
                self.errorAlert.1 = error.localizedDescription
            }
        })
        .onReceive(self.settingsVM.$passwordSuccess, perform: { value in
            self.passwordChangued = value
        })
        .onReceive(self.settingsVM.$emailSuccess, perform: { value in
            self.emailChangued = value
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
