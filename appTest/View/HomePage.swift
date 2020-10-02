//
//  HomePage.swift
//  appTest
//
//  Created by hh3 on 9/23/20.
//

import SwiftUI
import Firebase

struct HomePage: View {
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    @ObservedObject private var dataVM = DataViewModel()
    
    @State private var data = [DataModel]()
    @State private var errorAlert : (Bool,String) = (false,"")
    
    @State var show : Bool = false
    
    @Binding var login : Bool
    
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                List {
                    ForEach(self.data){ item in
                        NavigationLink(destination: EditView(item: item)){
                            VStack (alignment: .leading) {
                                Text(item.title)
                                    .font(.title)
                                    .bold()
                                Text(item.name)
                                Text(item.text)
                            }
                        }
                    }.onDelete(perform: { index in
                        self.dataVM.deleteSelected(index : index)
                    })
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action:{
                            self.show.toggle()
                        }){
                            Image(systemName: "plus")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .padding()
                        }
                    }
                }
            }.navigationBarItems(trailing:
                                    Button(action: {
                                        self.registrationVM.signOut()
                                    }, label: {
                                        Text("Sign Out")
                                    })
            )
            .sheet(isPresented: self.$show) {
                DataView()
            }
        }
        .onReceive(self.dataVM.$error, perform: { value in
            if let error = value {
                self.errorAlert.0.toggle()
                self.errorAlert.1 = error.localizedDescription
            }
        })
        
        .onReceive(self.dataVM.$data, perform: { value in
            self.data = value
        })
        
        .onReceive(self.registrationVM.$alreadySignIn, perform: { value in
            if value {
                self.login = false
            }
        })
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(login: .constant(false))
    }
}
