//
//  ProfileView.swift
//  appTest
//
//  Created by hh3 on 10/28/20.
//

import SwiftUI
import FirebaseStorage
import Firebase
import UIKit

struct ProfileView: View {
    @State private var user: UserModel = UserModel.init()
    @ObservedObject private var profileVM : ProfileViewModel = ProfileViewModel()
    @State private var showEdit : Bool = true
    @State private var showSheet : Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .shadow(radius: 3)
                .padding(.top,15)
            if self.showEdit {
                Text((self.user.name ?? "a") + " " + (self.user.surname ?? "a"))
                    .font(.title)
                    .fontWeight(.medium)
            } else {
                HStack {
                    TextField(self.user.name ?? "empty", text: self.$profileVM.name)
                    TextField(self.user.surname ?? "empty", text: self.$profileVM.surname)
                }.padding()
            }
                
            
            Form {
                    HStack {
                        Text("Phone")
                        Spacer()
                        if self.showEdit {
                        Text(self.user.phone ?? "")
                            .foregroundColor(.gray)
                            .font(.callout)
                        } else {
                            TextField(self.user.phone ?? "empty", text: self.$profileVM.phone)
                        }
                    }
                    HStack {
                        Text("Address")
                        Spacer()
                        if self.showEdit {
                        Text(self.user.address ?? "")
                            .foregroundColor(.gray)
                            .font(.callout)
                        } else {
                            TextField(self.user.address ?? "Empty", text: self.$profileVM.address)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    HStack {
                        Text("Age")
                        Spacer()
                        if self.showEdit {
                        Text(self.user.age ?? "")
                            .foregroundColor(.gray)
                            .font(.callout)
                        } else {
                            TextField(self.user.age ?? "Empty", text: self.$profileVM.age)
                                .multilineTextAlignment(.leading)
                                .keyboardType(.numberPad)
                        }
                    }
                    HStack {
                        Text("Height")
                        Spacer()
                        if self.showEdit {
                        Text((self.user.height ?? "") + "Cms")
                            .foregroundColor(.gray)
                            .font(.callout)
                        } else {
                            TextField(self.user.height ?? "Empty", text: self.$profileVM.height)
                                .multilineTextAlignment(.leading)
                                .keyboardType(.numberPad)
                        }
                    }
                    HStack {
                        Text("Weight")
                        Spacer()
                        if self.showEdit {
                        Text((self.user.weight ?? "" ) + "Kg")
                            .foregroundColor(.gray)
                            .font(.callout)
                        } else {
                            TextField(self.user.weight ?? "Empty", text: self.$profileVM.weight)
                                .multilineTextAlignment(.leading)
                                .keyboardType(.numberPad)
                        }
                    }
                }
            
            HStack {
                Button(action: {
                    self.showSheet.toggle()
                }) {
                    HStack {
                        Image(systemName: "folder.badge.person.crop")
                            .font(.title)
                        Text("Info")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(25)
                    .padding(.horizontal, 20)
                }
            }
            
        
                HStack {
                    Button(action: {
                        self.profileVM.saveUserData()
                        self.showEdit = true
                    }) {
                        HStack {
                            Image(systemName: "paperplane")
                                .font(.title)
                            Text("Save")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(25)
                        .padding(.horizontal, 20)
                    }
                    
                    Button(action: {
                        self.showEdit = false
                    }) {
                        HStack {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                            Text("Edit")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(25)
                        .padding(.horizontal, 20)
                    }
                }
            Spacer()
            
        }.padding(.top,60)
        .sheet(isPresented: self.$showSheet){
            UserDataView(userData : self.user)
        }
        .onReceive(self.profileVM.$userData, perform: { value in
            self.user = value
        })
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
