

import Foundation
import SwiftUI
import UIKit
import Photos

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var show : Bool
    @Binding var image : Data
    var source : UIImagePickerController.SourceType
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(conexion: self)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.allowsEditing = true
        controller.delegate = context.coordinator
        return controller
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var conexion : ImagePicker
        
        init(conexion : ImagePicker){
            self.conexion = conexion
            self.conexion.checkPermission()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.conexion.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let data = image.jpegData(compressionQuality: 0.30)
            self.conexion.image = data!
            self.conexion.show.toggle()
        }
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus(); switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .notDetermined: PHPhotoLibrary.requestAuthorization({
            (newStatus) in print("status is \(newStatus)"); if newStatus == PHAuthorizationStatus.authorized { print("success") }
        })
        case .restricted:  print("User do not have access to photo album.")
        case .denied:  print("User has denied the permission.")
        case .limited: print(" ")
        
        @unknown default:
            fatalError()
        }
        
    }
    
    
}
