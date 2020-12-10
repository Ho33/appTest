//
//  SwiftUIView.swift
//  appTest
//
//  Created by hh3 on 12/10/20.
//

import SwiftUI

struct HistoryDestailsView: View {
    @ObservedObject private var dataVM = DataViewModel()
    var item : DataModel
    
    @State var dateString : String = ""
    
    var body: some View {
        HStack () {
            VStack (alignment: .center, spacing: 10) {
                VStack {
                    Text("Training of " + item.title!)
                        .font(.title3)
                        .bold()
                    Text(self.dateString)
                }.padding()
            }
        }
        .onAppear{
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            self.dateString = formatter.string(from: item.date)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 0.5))
                .shadow(color: Color.black.opacity(0.2), radius: 5)
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDestailsView(item: DataModel.init(exerciseData: [ExerciseModel.init(name: "0", series: "0", reps: "0", text: "d"),ExerciseModel.init(name: "0", series: "0", reps: "0", text: "d")], title: "Arms", text: "Pegando los brazos", date: Date()))
    }
}
