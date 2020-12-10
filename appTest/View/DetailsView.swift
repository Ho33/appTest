//
//  EditView.swift
//  appTest
//
//  Created by hh3 on 10/2/20.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject private var dataVM = DataViewModel()

    var item : DataModel
    
    var body: some View {
        VStack {
            VStack {
                DisplayExercisesView(item: item) 
            }.overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 0.5))
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            Text("Guidelines of workout").font(.title).bold()
            Divider()
            Text(self.item.text!).padding()
            Spacer()
        }.padding(.top,-10)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(item: DataModel.init(exerciseData: [ExerciseModel.init( name: "123", series: "123", reps: "123", text: "123")], title: "123", text: "123"))
    }
}

