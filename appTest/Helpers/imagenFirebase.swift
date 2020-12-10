

import Foundation
import SwiftUI
import UIKit

let imagenAlternativa = UIImage(systemName: "photo")

struct imagenFirebase : View {
    
    @ObservedObject var imageLoader : Loader
    
    init(imageUrl: String) {
        self.imageLoader = Loader(imageUrl: imageUrl)
    }
    
    var image: UIImage? {
        self.imageLoader.data.flatMap(UIImage.init)
    }
    
    var body : some View {
        Image(uiImage: image ?? imagenAlternativa!)
            .resizable()
            .cornerRadius(20)
            .shadow(radius: 5)
            .aspectRatio(contentMode: .fill)
    }
}
