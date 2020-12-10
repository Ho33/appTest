//
//  HistoryView.swift
//  appTest
//
//  Created by hh3 on 10/28/20.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject private var dataVM = DataViewModel()
    @State private var data : [DataModel] = []
    var body: some View {
        VStack {
            ScrollView (showsIndicators: false) {
                VStack () {
                    ForEach(self.data){ item in
                        NavigationLink(destination: DetailsView(item: item)){
                            VStack{
                                HistoryDestailsView(item: item)
                                    .animation(.spring(response: 0.4, dampingFraction: 0.9))
                                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                            }
                        }.buttonStyle(PlainButtonStyle())
                        .animation(.spring(response: 0.4, dampingFraction: 0.9))
                    }
                }
            }.animation(.spring(response: 0.4, dampingFraction: 0.9))
        }.padding(EdgeInsets(top: 90, leading: 0, bottom: -400, trailing: 0))
        .onReceive(self.dataVM.$trainingsDone, perform: { value in
            data = value
        })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
