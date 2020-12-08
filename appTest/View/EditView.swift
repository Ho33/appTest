//
//  EditView.swift
//  appTest
//
//  Created by hh3 on 10/2/20.
//

import SwiftUI

struct EditView: View {
    
    @ObservedObject private var dataVM = DataViewModel()

    var item : DataModel
    
    var body: some View {
        VStack {
            Text(self.item.title!)
            
                ForEach(self.item.exerciseData!){ exercise in
                    VStack{
                        Group {
                            HStack {
                                Text("Name: ")
                                Text(exercise.name)
                            }
                            HStack {
                                Text("Number of series: ")
                                Text(exercise.series)
                            }
                            HStack {
                                Text("Number of reps: ")
                                Text(exercise.reps)
                            }
                            HStack {
                                Text("Indications: ")
                                Text(exercise.text)
                            }
                        }
                        Spacer()
                    }.padding()
                }
            Text(self.item.text!)
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(item: DataModel.init(email: "", exerciseData: [ExerciseModel.init( name: "123", series: "123", reps: "123", text: "123")], title: "123", text: "123"))
    }
}
