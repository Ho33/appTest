//
//  DisplayExercisesView.swift
//  appTest
//
//  Created by hh3 on 12/9/20.
//

import SwiftUI

struct DisplayExercisesView: View {
    
    var item : DataModel
    
    var body: some View {
        ScrollView {
            ForEach(self.item.exerciseData!){ exercise in
                VStack{
                    HStack{
                        Group{
                            HStack{
                                Image(systemName: "arrow.right")
                                Text(exercise.name)
                            }
                            HStack{
                                Text("Series")
                                Image(systemName: "multiply")
                                Text(exercise.series)
                            }
                            HStack{
                                Text("Reps")
                                Image(systemName: "multiply")
                                Text(exercise.reps)
                            }
                        }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                        .animation(.spring(response: 0.4, dampingFraction: 0.9))
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    Divider()
                    HStack{
                        Text(exercise.text)
                    }.padding()
                }.overlay(
                    RoundedRectangle(cornerRadius: 20,style: .continuous)
                        .stroke(Color.black, lineWidth: 0.5))
                .shadow(radius: 10)
                .padding()
                
            }
        }
    }
}


struct DisplayExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayExercisesView(item: DataModel(exerciseData: [ExerciseModel.init(name: "hola", series: "2", reps: "3", text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")], title: "String?", text: "String?"))
    }
}
