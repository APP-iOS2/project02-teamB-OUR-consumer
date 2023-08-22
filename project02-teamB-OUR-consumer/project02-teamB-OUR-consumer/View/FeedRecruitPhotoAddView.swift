//
//  FeedRecruitPhotoAddView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 윤해수 on 2023/08/22.
//

import SwiftUI

struct FeedRecruitPhotoAddView: View {
    
    @State private var selectedImages: [UIImage] = []
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("사진 추가") {
                    isImagePickerPresented = true
                }
            }
            .padding()
            
            if selectedImages.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(1..<6) { _ in
                            ZStack {
                                Rectangle()
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.black)
                                    .frame(width: 100, height: 100)
                                    .border(.black)
                                Image(systemName: "plus")
                                    .font(.system(size: 80, weight: .thin))
                            }
                        }
                    }
                }
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fit)
                                .overlay {
                                    Rectangle().stroke(.black, lineWidth: 2)
                                }
                                
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            FeedRecruitPHPickerViewControllerWrapper(selectedImages: $selectedImages)
        }
    }
}

struct FeedRecruitPhotoAddView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitPhotoAddView()
    }
}
