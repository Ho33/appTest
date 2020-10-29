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
    var selectedButtonColor : Color?
    
    var body: some View {

                HStack(spacing: 22){
                    Image(systemName: self.image)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.selectedButtonColor ?? self.bColor)
                        
                    Text(self.buttonName).foregroundColor(self.bColor)
                }
                .padding(.top,25)                
            }
}
