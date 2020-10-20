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
    @State private var offset = CGFloat.zero
    @State private var closeOffset = CGFloat.zero
    @State private var openOffset = CGFloat.zero
    @State private var disableView = true
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                TabView{
                    NavigationView {
                        ZStack () {
                            List {
                                ForEach(self.data){ item in
                                    NavigationLink(destination: EditView(item: item)){
                                        VStack () {
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
                       
                        .allowsHitTesting(disableView)
                        .navigationBarItems(leading: Button(action: {
                            self.disableView = false
                            self.offset = self.openOffset
                        }){
                            Image(systemName: "list.bullet")
                        })
                        .edgesIgnoringSafeArea(.top)
                        
                    }
                    .sheet(isPresented: self.$show) {
                        DataView()
                    }
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
            
            
            // Slide menu
            UserSlideMenu()
                .onAppear(perform: {
                    self.offset = geometry.size.width * -1
                    self.closeOffset = self.offset
                    self.openOffset = .zero
                })
                .offset(x: self.offset)
                .animation(.default)
        }
        .gesture(DragGesture(minimumDistance: 5)
                    .onChanged{ value in
                        if (self.offset < self.openOffset) {
                            self.disableView = false
                            self.offset = self.closeOffset + value.translation.width
                        }
                    }
                    .onEnded { value in
                        if (value.location.x > value.startLocation.x) {
                            self.disableView = false
                            self.offset = self.openOffset
                        } else {
                            self.disableView = true
                            self.offset = self.closeOffset
                        }
                    }
        )
    }
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
