//
//  PostModifyDetailPhotoEditorView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/31.
//

import SwiftUI
import PhotosUI

struct PostModifyDetailPhotoEditorView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    @State private var isImagePickerPresented: Bool = false
    @State var imageData : [UIImage] = []
    @Binding var selectedImages: [UIImage]
    @Binding var selectedItem: [PhotosPickerItem]
    
    var xBox: Bool {
        
        if selectedItem != [] {
            
            return true
        }
        return false
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("사진추가")
                    .foregroundColor(.accentColor)
                Spacer()
            }
            if postViewModel.postModel.postImagePath.isEmpty {
                PhotosPicker(selection: $selectedItem, matching: .any(of: [.images,.videos]), photoLibrary: .shared()) {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .font(.system(size: 40, weight: .thin))
                        .padding(40)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
            } else {
                HStack{
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack{
                            PhotosPicker(selection: $selectedItem, matching: .any(of: [.images,.videos]), photoLibrary: .shared()) {
                                Image(systemName: "plus")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 40, weight: .thin))
                                //                                    .padding(40)
                                    .frame(maxWidth: 150, maxHeight: 150)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            }
                            ForEach(imageData, id:\.self) { image in
                                VStack{
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                    //.scaledToFill()
                                        .frame(width:150, height:150)
                                        .cornerRadius(10)
                                }
                                
                            }
                            
                            ForEach(postViewModel.postModel.postImagePath, id: \.self) { imagePath in
                                AsyncImage(url: URL(string: imagePath)) { image in
                                    image
                                        .resizable()
                                        .frame(width:150, height:150)
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        
                    }
                    
                }
            }
        }
        .onChange(of: selectedItem) { newImages in
            var images : [UIImage] = []
            Task{

                for image in newImages {
                    if let data =  try await image.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            images.append(uiImage)
                            print("온체인지-1\(uiImage)")

                        }
                    }
                }
                imageData = images
                print("온체인지 \(imageData)")
            }

        }
    }
}
//struct PostModifyDetailPhotoEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostModifyDetailPhotoEditorView(post: <#Post#>, selectedImages: <#Binding<[UIImage]>#>, selectedItem: <#Binding<[PhotosPickerItem]>#>)
//    }
//}
