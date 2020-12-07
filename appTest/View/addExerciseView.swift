//
//  addExerciseView.swift
//  appTest
//
//  Created by hh3 on 12/7/20.
//

import SwiftUI

struct addExerciseView: View {
    
    @Binding var exercise : [ExerciseModel]
    @Binding var show : Bool
    @State private var name : String = ""
    @State private var series : String = ""
    @State private var reps : String = ""
    @State private var text : String = ""
    
    var body: some View {
        VStack{
            SingleFormView(fieldName: "name", fieldValue: self.$name, isProtected: false)
            SingleFormView(fieldName: "series", fieldValue: self.$series, isProtected: false)
            SingleFormView(fieldName: "reps", fieldValue: self.$reps, isProtected: false)
            SingleFormView(fieldName: "text", fieldValue: self.$text, isProtected: false)
            Button(action:{
                exercise.append(ExerciseModel.init(name: self.name, series: self.series, reps: self.reps, text: self.text))
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
struct addExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        addExerciseView(exercise: .constant([ExerciseModel.init(name: "0", series: "0", reps: "0", text: "d")]), show: .constant(true))
    }
}
