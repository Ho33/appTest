//
//  ProfileImageView.swift
//  appTest
//
//  Created by hh3 on 12/9/20.
//

import SwiftUI
import FirebaseStorage
import Firebase


struct ProfileImageView: View {
   
        @Binding var show : Bool
        @State private var titulo = ""
        @State private var texto = ""
        
        @State private var imageData : Data = .init(capacity: 0)
        @State private var mostrarMenu = false
        @State private var imagePicker = false
        @State private var source : UIImagePickerController.SourceType = .camera
        
        private func guardar(){
            // guardar storage
            let storage = Storage.storage().reference()
            let nombreImagen = UUID()
            let directorio = storage.child("imagenesPost/\(nombreImagen)")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            directorio.putData(self.imageData, metadata: metadata) { (data, error) in
                if error == nil {
                    print("guardo imagen")
                    self.show.toggle()
                }else{
                    if let error = error?.localizedDescription {
                        print("error en firebase al cargar imagen", error)
                    }else{
                        print("error en imagenes")
                    }
                }
            }
            
//             guardar texto
//            let db = Firestore.firestore()
//            guard let email = Auth.auth().currentUser?.email else { return  }
//            let campos : [String:Any] = ["titulo":self.titulo,"texto":self.texto, "email":email, "imagen":String(describing:directorio)]
//            db.collection("Posts").addDocument(data: campos) { (error) in
//                if let error = error {
//                    print("Fallo al guardar", error.localizedDescription)
//                }else{
//                    print("guardo correctamente")
//                }
//            }
        }
        
        var body: some View {
            NavigationView {
                VStack{
                    HStack{
                        Spacer()
                        Button(action:{
                            self.guardar()
                            
                        }){
                            Text("Save")
                        }
                    }
                    
                    TextField("Titulo", text: self.$titulo)
                    multilineTextField(texto: self.$texto)
                    if self.imageData.count != 0{
                        Image(uiImage: UIImage(data: self.imageData)!)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(15)
                    }
                    
                    Button(action:{
                        self.mostrarMenu.toggle()
                    }){
                        Text("Cargar imagen")
                    }.actionSheet(isPresented: self.$mostrarMenu) {
                        ActionSheet(title: Text("Menu"), message: Text("Selecciona una opción"), buttons: [
                            .default(Text("Camara"), action: {
                                self.source = .camera
                                self.imagePicker.toggle()
                            }),
                            .default(Text("Libreria"), action: {
                                self.source = .photoLibrary
                                self.imagePicker.toggle()
                            }),
                            .default(Text("Cancelar"))
                        
                        ])
                        
                    }
                    
                }
                .padding(.all)
            }.sheet(isPresented: self.$imagePicker, content: {
                    ImagePicker(show: self.$imagePicker, image: self.$imageData, source: source)
            })
        }
    }


struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(show: .constant(false))
    }
}
