//
//  Utilitie.swift
//  appTest
//
//  Created by hh3 on 9/28/20.
//

import Foundation
import Firebase
import SwiftUI

struct Utilities {
    
    
    func setSessionStatus(bol : Bool, name: String) -> Void {
        UserDefaults.standard.set(bol, forKey: name)
    }
    func setUser(User: User){
        UserDefaults.standard.setValue(User.uid, forKey: "userUid")
    }
   
    func getGroupImage(type: String) -> String {
        switch type {
            case "Arms":
                return "brazo"
            case "Legs":
                return "piernas"
            case "Back":
                return "espalda"
            case "Chest":
                return "pecho"
            case "Shoulders":
                return "hombros"
            default:
                return ""
        }
    }
    
    struct NeumorphicButtonStyle: ButtonStyle {
        var bgColor: Color

        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding(20)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .shadow(color: .white, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                            .shadow(color: .black, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                            .blendMode(.overlay)
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(bgColor)
                    }
            )
                .scaleEffect(configuration.isPressed ? 0.95: 1)
                .foregroundColor(.primary)
                .animation(.spring())
        }
    }
}
