//
//  FeedRecruitImagePicker.swift
//  project02-teamB-OUR-consumer
//
//  Created by 윤해수 on 2023/08/22.
//

import SwiftUI
import PhotosUI

struct FeedRecruitPHPickerViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // 선택가능한 사진의 갯수, 0은 무제한

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: FeedRecruitPHPickerViewControllerWrapper

        init(_ parent: FeedRecruitPHPickerViewControllerWrapper) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages = []
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.selectedImages.append(image)
                            }
                        }
                    }
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIImage {
    func toString() -> String? {

        let pngData = self.pngData()

        return pngData?.base64EncodedString(options: .lineLength64Characters)
    }
}
