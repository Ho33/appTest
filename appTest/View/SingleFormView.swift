//
//  SingleFormView.swift
//  appTest
//
//  Created by hh3 on 9/28/20.
//

import SwiftUI

struct SingleFormView: View {
    
    var fieldName: String
    @Binding var fieldValue: String
    var isProtected: Bool
    
    var body: some View {
        
        let colorLightGray = Color.init(.lightGray)
        let radiux : CGFloat = 30.0

        VStack{
            if isProtected{
                SecureField(fieldName, text: $fieldValue)
                    .padding()
                    .background(colorLightGray)
                    .cornerRadius(radiux)
                    .padding(.horizontal)
            }else {
                TextField(fieldName, text: $fieldValue)
                    .padding().background(colorLightGray).cornerRadius(radiux).padding()
            }
        }
    }
}



