//
//  SingleSlideButtonView.swift
//  appTest
//
//  Created by hh3 on 10/15/20.
//

import SwiftUI

struct SingleSlideButtonView: View {
    
    var buttonName : String
    var image : String
    var bColor : Color
    
    var body: some View {

                HStack(spacing: 22){
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(bColor)
                    
                    Text(buttonName).foregroundColor(.black)
                }
                .padding(.top,25)
            }
}
