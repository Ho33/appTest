//
//  DataView.swift
//  appTest
//
//  Created by hh3 on 9/29/20.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject private var dataVM = DataViewModel()
    
    @Binding var show : Bool
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    SingleFormView(fieldName: "Tittle", fieldValue: self.$dataVM.tittle, isProtected: false)
                    SingleFormView(fieldName: "Name", fieldValue: self.$dataVM.name, isProtected: false)
                    SingleFormView(fieldName: "body", fieldValue: self.$dataVM.body, isProtected: false)
                }
                Button(action: {
                    self.dataVM.saveData()
                    self.show.toggle()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(show: .constant(false))
    }
}
