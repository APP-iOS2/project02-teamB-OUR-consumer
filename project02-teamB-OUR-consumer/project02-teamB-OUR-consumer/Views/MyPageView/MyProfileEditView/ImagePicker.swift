//
//  ImagePickerView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    
    var selectImage: ((UIImage) -> Void)
    
    func makeUIViewController(context: Context) -> some UIViewController {
        // PHPicker
        var config = PHPickerConfiguration()
        config.filter = .any(of: [.images, .livePhotos])
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print(results)

            parent.isPresented = false
            
            let itemProvider = results.first?.itemProvider
            if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async { [weak self] in
                        let uiImage = image as? UIImage
                        
                        if let uiImage = uiImage {
                            self?.parent.selectImage(uiImage)
                        }
                    }
                }
            }
        }
    }
}
