//
//  DataView.swift
//  appTest
//
//  Created by hh3 on 9/29/20.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject private var dataVM = DataViewModel()
    @ObservedObject private var registrationVM = RegistrationViewModel()
    
    @State private var tittle : String = ""
    @State private var name : String = ""
    @State private var text : String = ""
    @State private var userUid : String = ""
    @State private var errorAlert : (Bool,String) = (false,"")
    
    @Binding var show : Bool
    
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    SingleFormView(fieldName: "Tittle", fieldValue: self.$tittle, isProtected: false)
                    SingleFormView(fieldName: "Name", fieldValue: self.$name, isProtected: false)
                    SingleFormView(fieldName: "body", fieldValue: self.$text, isProtected: false)
                }
                Button(action: {
                    self.dataVM.saveData(title: self.tittle, name: self.name, text: text)
                }, label: {
                    Text("Save")
                })
            }
        }.alert(isPresented: self.$errorAlert.0) {
            Alert(title: Text("ERROR") , message: Text(self.errorAlert.1), dismissButton: .default(Text("OK")))
        
        }
        .onReceive(self.dataVM.$error, perform: { value in
            if let error = value{
                self.errorAlert.0.toggle()
                self.errorAlert.1 = error.localizedDescription
            }
        })
        .onReceive(self.dataVM.$saved, perform: { value in
            if value {
                self.show = false
            }
        })
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(show: .constant(false))
    }
}
