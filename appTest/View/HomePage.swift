//
//  HomePage.swift
//  appTest
//
//  Created by hh3 on 9/23/20.
//

import SwiftUI

struct HomePage: View {
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    @ObservedObject private var dataVM = DataViewModel()
    
    @Binding var login : Bool
    @State var show : Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                List {
                    ForEach(self.dataVM.data){ item in
                        VStack (alignment: .leading) {
                            Text(item.title)
                                .font(.title)
                                .bold()
                            Text(item.name)
                            Text(item.body)
                            Text(item.email)
                            }
                        }
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
                                Button(action: { self.registrationVM.signOut()
                                    self.login.toggle()
                                }, label: {
                                    Text("Sign Out")
                                })
        )
        .sheet(isPresented: self.$show) {
            DataView(show: self.$show)
        }
    }
}
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(login: .constant(false))
    }
}
