
import Foundation
import Firebase
import Combine
import UIKit

class Loader: ObservableObject {
    
    var didChenge = PassthroughSubject<Data?,Never>()
    
    @Published var data: Data? = nil {
        didSet {
            didChenge.send(data)
        }
    }
    
    init(imageUrl: String) {
        let storageImagen = Storage.storage().reference(forURL: imageUrl)
        storageImagen.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("error ", error.localizedDescription)
            }else{
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
    
}
