//
//  DisplayDataView.swift
//  appTest
//
//  Created by hh3 on 12/9/20.
//

import SwiftUI

struct DisplayDataView: View {
    @ObservedObject private var dataVM = DataViewModel()
    var item : DataModel
    
    var body: some View {
        HStack () {
            Image(Utilities().getGroupImage(type: item.title!))
                .resizable()
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 1))
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .padding(.leading,5)
            
            VStack (alignment: .center, spacing: 10) {
                Text("Training of " + item.title!)
                    .font(.title3)
                    .bold()
            }
            VStack {
                HStack {
                    Spacer()
                    Button(action:{
                        self.dataVM.deleteRow(id: item.id!)
                    }){
                        Image(systemName: "trash.circle")
                            .font(.title)
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .clipShape(Circle())
                            .padding()
                    }
                }
                HStack {
                    Spacer()
                    Button(action:{
                        self.dataVM.isDone(item: item)
                    }){
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .clipShape(Circle())
                            .padding()
                    }
                }
            }
            Spacer()	
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 0.5))
                .shadow(color: Color.black.opacity(0.2), radius: 5)
    }
}

struct DisplayDataView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayDataView(item: DataModel.init(exerciseData: [ExerciseModel.init(name: "0", series: "0", reps: "0", text: "d"),ExerciseModel.init(name: "0", series: "0", reps: "0", text: "d")], title: "Arms", text: "Pegando los brazos", date: Date()))
    }
}
