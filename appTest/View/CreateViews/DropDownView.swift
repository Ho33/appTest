//
//  DropDownView.swift
//  appTest
//
//  Created by hh3 on 12/9/20.
//

import SwiftUI

struct DropDownView: View {
    @State private var isExpanded = false
    @Binding var groups: [String]
    @Binding var selectedText: String
    var title : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(self.title)
                .font(.title3)
            DisclosureGroup("\(self.selectedText)", isExpanded: self.$isExpanded){
                ScrollView{
                VStack{
                    ForEach(self.groups, id: \.self){ text in
                        Text("\(text)")
                            .font(.title3)
                            .padding(.all)
                            .onTapGesture {
                                self.selectedText = text
                                withAnimation{
                                    self.isExpanded.toggle()
                                }
                            }
                    }
                }
                }.frame(height: 150)
            }.accentColor(.white)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.all)
            .background(Color.blue)
            .cornerRadius(8)
            Spacer()
        }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
}

//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDownView(groups: Binding<[String]>, selectedText: <#T##Binding<String>#>)
//    }
//}
