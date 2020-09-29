//
//  ErrorViewModel.swift
//  appTest
//
//  Created by hh3 on 9/29/20.
//

import Foundation
import Combine


class ErrorViewModel: ObservableObject {
    
    
    @Published var errorMessage: String =  ""
    @Published var hasError: Bool = false
    
    
    func setErrorMessage(error : String){
        //todo
    }
    
    func toggleError(){
        //todo
    }
}
