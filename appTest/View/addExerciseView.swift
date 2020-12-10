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
    @State private var series: [String] = ["1","2","3","4","5","7","8","9","10"]
    @State private var reps: [String] = ["1","2","3","4","5","7","8","9","10"]
    @State private var nameSelected : String = ""
    @State private var seriesSelected : String = "1"
    @State private var repsSelected : String = "1"
    @State private var textSelected : String = ""
    
    
    var body: some View {
        VStack{
            SingleFormView(fieldName: "Name of the Exercise", fieldValue: self.$nameSelected, isProtected: false)
            DropDownView(groups: self.$series, selectedText: self.$seriesSelected,title : "Number of series")
            DropDownView(groups: self.$reps, selectedText: self.$repsSelected,title : "Number of reps")
            multilineTextField(texto: self.$textSelected)
            
            Button(action:{
                exercise.append(ExerciseModel.init(name: self.nameSelected, series: self.seriesSelected, reps: self.repsSelected, text: self.textSelected))
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
        }.padding()
    }
}
struct addExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        addExerciseView(exercise: .constant([ExerciseModel.init(name: "0", series: "0", reps: "0", text: "d")]), show: .constant(true))
    }
}
