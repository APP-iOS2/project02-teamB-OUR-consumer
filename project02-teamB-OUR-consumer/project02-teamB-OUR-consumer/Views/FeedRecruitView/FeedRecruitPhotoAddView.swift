//
//  FeedRecruitPhotoAddView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 윤해수 on 2023/08/22.
//

import SwiftUI
import PhotosUI

struct FeedRecruitPhotoAddView: View {
    
    @Binding var selectedItem: PhotosPickerItem?
    
    @Binding var selectedImages: [UIImage]
    @State private var isImagePickerPresented: Bool = false
    @State var imageData : Data? = nil
    
    var body: some View {
        VStack {
            
            if imageData == nil {
                HStack {
                    
                    Text("사진추가")
                    Spacer()
                }
                .padding()
                
                
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .font(.system(size: 40, weight: .thin))
                        .padding(40)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                }
            } else {
                HStack {
                    
                    Text("사진추가")
                    Spacer()
                }
                .padding()
                
                ZStack{
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                        Image(systemName: "plus")
                            .foregroundColor(.gray)
                            .font(.system(size: 40, weight: .thin))
                            .padding(40)
                            .frame(maxWidth: .infinity, maxHeight: 150)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        
                    }
                    
                    
                    if let imageData,
                       let image = UIImage(data: imageData) {
                        
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150, alignment: .center)
                        
                    }
                    
                }
                    
                    
                }
                
            }

        
        
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    self.imageData = data
                }
            }
        }
        //        .sheet(isPresented: $isImagePickerPresented) {
        //            FeedRecruitPHPickerViewControllerWrapper(selectedImages: $selectedImages)
        //        }
    }
}

//struct FeedRecruitPhotoAddView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedRecruitPhotoAddView()
//    }
//}

//
//
//    .onChange(of: selectedItem) { newItem in
//                Task {
//                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                        self.imageData = data
//                    }
//                }
//            }

