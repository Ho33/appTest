//
//  DataView.swift
//  appTest
//
//  Created by hh3 on 9/29/20.
//

import SwiftUI

struct CreateView: View {
    
    @ObservedObject private var dataVM = DataViewModel()
    
    @State private var name : String = ""
    @State private var text : String = ""
    @State private var userUid : String = ""
    @State private var groups: [String] = ["Back","Chest","Shoulders","Legs","Arms"]
    @State private var goupSelected : String = "Back"
    @State private var exercise : [ExerciseModel] = []
    @State private var show : Bool = false
    @State private var errorAlert : (Bool,String) = (false,"")
    
    @Binding var showCreate : Bool
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("CREATE").font(.system(size: 20)).fontWeight(.ultraLight).padding().frame(width:220 , height:60).foregroundColor(.blue)
                    DropDownView(groups: self.$groups, selectedText: self.$goupSelected, title: "Select group of Muscle")
                    Group{
                        VStack{
                            List{
                                ForEach(self.exercise){ item in
                                    HStack{
                                        Text(item.name)
                                        Text(item.series)
                                        Text(item.reps)
                                        Text(item.text)
                                    }
                                }
                            }
                        }
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
                    multilineTextField(texto: self.$text)
                }
                Button(action: {
                    self.dataVM.saveData(title: self.goupSelected, exercise: self.exercise, text: self.text)
                    self.showCreate.toggle()
                }) {
                    Text("Save")
                        .frame(width: 250 , height: 55)
                        .foregroundColor(Color.white).background(Color.blue)
                        .cornerRadius(30.0)
                }.padding(.top,30)
                Spacer()
            }
            
        }.sheet(isPresented: self.$show) {
            addExerciseView(exercise : self.$exercise, show: self.$show)
        }
        .alert(isPresented: self.$errorAlert.0) {
            Alert(title: Text("ERROR") , message: Text(self.errorAlert.1), dismissButton: .default(Text("OK")))
        
        }
        .onReceive(self.dataVM.$error, perform: { value in
            if let error = value{
                self.errorAlert.0.toggle()
                self.errorAlert.1 = error.localizedDescription
            }
        })
        
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(showCreate: .constant(false))
    }
}
