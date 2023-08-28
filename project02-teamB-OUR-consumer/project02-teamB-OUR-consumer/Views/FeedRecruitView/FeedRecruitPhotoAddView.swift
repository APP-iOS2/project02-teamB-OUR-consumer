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
    var xBox: Bool {
        
        if selectedItem != nil {
            
            return true
        }
        return false
    }
    
    var body: some View {
        VStack {
            
            if imageData == nil {
                HStack {
                    
                    Text("사진추가")
                        .foregroundColor(.accentColor)
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
                        .foregroundColor(.accentColor)
                    Spacer()
                }
                .padding()
                
                
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    ZStack{
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.clear)
                            .buttonBorderShape(.roundedRectangle)
                            .border(Color.gray)
                        HStack{
                            if let imageData,
                               let image = UIImage(data: imageData) {
                                
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 250, height: 150, alignment: .center)
                            }
                            if xBox {
                                Button {
                                    imageData = nil
                                } label: {
                                    Label("Delete", systemImage: "xmark.circle")
                                }
                                .padding()
                            }
                            
                            
                            
                        }
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
        
    }
}


