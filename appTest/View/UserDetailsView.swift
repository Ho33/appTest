//
//  UserDetailsView.swift
//  appTest
//
//  Created by hh3 on 10/9/20.
//

import SwiftUI

struct UserDetailsView: View {
    var body: some View {
           VStack(alignment: .leading) {
               Image("")
                   .resizable()
                   .overlay(
                    Circle().stroke(Color.black, lineWidth: 1))
                   .frame(width: 60, height: 60)
                   .clipShape(Circle())
               Text("user name")
                   .font(.largeTitle)
            Divider()
               Spacer()
            //todo buttons
           }
           .padding(EdgeInsets(top: 45, leading: 20, bottom: 0, trailing: 0))
           .frame(width: UIScreen.main.bounds.width / 1.5)
           .background(Color.white)
           .edgesIgnoringSafeArea(.all)
           .overlay(Rectangle().stroke(Color.primary.opacity(0.2),lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(.all))
           
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView()
    }
}
