//
//  UserDataView.swift
//  appTest
//
//  Created by hh3 on 12/10/20.
//

import SwiftUI

struct UserDataView: View {
    var userData : UserModel
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Text("Perfil Nutricional")
                        .font(.largeTitle)
                }
                HStack {
                    Text("Segun sus datos")
                        .font(.title3)
                }
            }.padding(.top,30)
            Form{
                HStack {
                    Text("Metabolismo Basal")
                    Spacer()
                    Text(self.calcularMetabolismoBasal())
                }
                HStack {
                    Text("Calorias Necesarias")
                    Spacer()
                    Text(self.calcularCaloriasConsumir())
                }
                HStack {
                    Text("Proteinas a consumir")
                    Spacer()
                    Text(self.calcularProteina())
                }
                HStack {
                    Text("Grasas a consumir")
                    Spacer()
                    Text(self.calcularGrasas())
                }
                HStack {
                    Text("Carbohidratos a consumir")
                    Spacer()
                    Text(self.calcularHidratos())
                }
            }
        }
    }
    
    func calcularMetabolismoBasal() -> String {
        let peso = Int(self.userData.weight!)
        let result = 1 * peso! * 24
        return String(result)
    }
    func calcularCaloriasConsumir() -> String {
        let peso = Int(self.userData.weight!)
        let result = Int(15.3) * peso! + 679
        return String(result)
    }
    func calcularProteina() -> String{
        let mbasal = Int(self.calcularMetabolismoBasal())
       return String((15 * mbasal!) / 100)
    }
    func calcularGrasas() -> String{
        let mbasal = Int(self.calcularMetabolismoBasal())
       return String((30 * mbasal!) / 100)
    }
    func calcularHidratos() -> String{
        let mbasal = Int(self.calcularMetabolismoBasal())
       return String((55 * mbasal!) / 100)
    }
}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        UserDataView(userData: UserModel.init(name: "", surname: "", age: "22", phone: "", address: "", weight: "82", height: "175"))
    }
}
