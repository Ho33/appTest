//
//  EditView.swift
//  appTest
//
//  Created by hh3 on 10/2/20.
//

import SwiftUI

struct EditView: View {
    
    @ObservedObject private var dataVM = DataViewModel()
    
    @State private var title : String = ""
    @State private var name : String = ""
    @State private var email : String = ""
    @State private var text : String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var item : DataModel
    
    var body: some View {
        VStack {
            Text("EDIT ENTRIE").font(.system(size: 25)).fontWeight(.ultraLight).padding().frame(width:220 , height:60)
            SingleFormView(fieldName: self.item.title , fieldValue: self.$title, isProtected: false)
            SingleFormView(fieldName: self.item.name , fieldValue: self.$name,isProtected: false)
            SingleFormView(fieldName: self.item.text , fieldValue:  self.$text, isProtected: false)
            Button(action: {
                self.dataVM.editSelected(item: self.item, title: self.title, name: self.name, text: self.text)
            }) {
                Text("SAVE CHANGUES")
                    .frame(width: 250 , height: 55)
                    .foregroundColor(Color.white).background(Color.gray)
                    .cornerRadius(30.0)
            }
            .padding()
            .animation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0.1))
            Spacer()
            
        }.onReceive(self.dataVM.$isEdited, perform: { value in
            if value{
                self.presentationMode.wrappedValue.dismiss()
            }
        })
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(item: DataModel.init(id: "", email: "", title: "", name: "", text: ""))
    }
}
