//
//  HomeView.swift
//  appTest
//
//  Created by hh3 on 10/28/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var registrationVM = RegistrationViewModel()
    @ObservedObject private var dataVM = DataViewModel()
    
    @State private var data = [DataModel]()
    @State private var errorAlert : (Bool,String) = (false,"")
    @State var show : Bool = false
    
    var body: some View {
        
        TabView{
                ZStack () {
                    List {
                        ForEach(self.data){ item in
                            NavigationLink(destination: EditView(item: item)){
                                HStack () {
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
                }
            }
            .sheet(isPresented: self.$show) {
                DataView()
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
