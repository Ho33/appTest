//
//  multilineTextField.swift
//  FirebaseSwiftUI
//
//  Created by Jorge Maldonado Borbón on 28/11/19.
//  Copyright © 2019 Jorge Maldonado Borbón. All rights reserved.
//

import Foundation
import SwiftUI

struct multilineTextField : UIViewRepresentable {
    
    @Binding var texto : String
    
    func makeCoordinator() -> multilineTextField.Coordinator {
        return multilineTextField.Coordinator(conexion: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<multilineTextField>) -> UITextView {
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = "Guidelines..."
        text.textColor = .gray
        text.font = .systemFont(ofSize: 15)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<multilineTextField>) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var conexion : multilineTextField
        
        init(conexion : multilineTextField) {
            self.conexion = conexion
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.conexion.texto = textView.text
        }
        
    }
    
}
