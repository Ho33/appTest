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
    @State var showCreate : Bool = false

    var body: some View {
        
        VStack {
            ScrollView (showsIndicators: false) {
                VStack () {
                    ForEach(self.data){ item in
                        NavigationLink(destination: DetailsView(item: item)){
                            VStack{
                                DisplayDataView(item: item)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.black, lineWidth: 0.5))
                                            .shadow(color: Color.black.opacity(0.2), radius: 5)
                                    .animation(.spring(response: 0.4, dampingFraction: 0.9))
                                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                            }
                        }.buttonStyle(PlainButtonStyle())
                        .animation(.spring(response: 0.4, dampingFraction: 0.9))
                    }
                }
            }.animation(.spring(response: 0.4, dampingFraction: 0.9))
        }.padding(EdgeInsets(top: 80, leading: 0, bottom: -400, trailing: 0))
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action:{
                                self.showCreate.toggle()
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
                
        .sheet(isPresented: self.$showCreate) {
            CreateView(showCreate: self.$showCreate)
            }
                
        .onReceive(self.dataVM.$error, perform: { value in
            if let error = value {
                self.errorAlert.0.toggle()
                self.errorAlert.1 = error.localizedDescription
            }
        })
        .onReceive(self.dataVM.$trainings, perform: { value in
            self.data = value
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
