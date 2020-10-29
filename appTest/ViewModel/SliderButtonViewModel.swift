//
//  SliderButtonViewModel.swift
//  appTest
//
//  Created by hh3 on 10/28/20.
//

import Combine
import SwiftUI


class SilderButtonViewModel : ObservableObject {

    static let shared = SilderButtonViewModel()
    private init() {}
    
    @Published var currentButton : Int = 0
    
    func setIndexCurrentButton (index: Int){
        self.currentButton = index
    }
}
