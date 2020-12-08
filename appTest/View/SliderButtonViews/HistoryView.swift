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
        VStack{
            List{
                ForEach(data){value in
                    Text(value.title!)
                }
            }
        }.onReceive(self.dataVM.$trainingsDone, perform: { value in
            data = value
        })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
