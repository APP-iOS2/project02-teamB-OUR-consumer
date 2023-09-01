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
    var post: Post
    
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
                Text("사진")
                    .foregroundColor(.accentColor)
                Spacer()
            }
            if imageData.isEmpty {
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
                            ForEach(imageData, id:\.self) { image in
                                VStack{
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                    //.scaledToFill()
                                        .frame(width:150, height:150)
                                        .cornerRadius(10)
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
                
                for image in images {
                    selectedImages.append(image)
                }
                print("온체인지 \(imageData)")
            }
            
        }
        .onAppear {
            convertImageUrlsToUIImages(from: post.postImagePath) { uiImages in
                imageData = uiImages
                selectedImages = uiImages
            }
        }
    }
    
    func convertImageUrlsToUIImages(from imageUrls: [String], completion: @escaping ([UIImage]) -> ()) {
        var uiImages: [UIImage] = []
        
        let group = DispatchGroup()
        let concurrentQueue = DispatchQueue(label: "imageConversionQueue", attributes: .concurrent)
        
        for imageUrl in imageUrls {
            group.enter()
            concurrentQueue.async {
                if let url = URL(string: imageUrl), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    uiImages.append(image)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(uiImages)
        }
    }
}
//struct PostModifyDetailPhotoEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostModifyDetailPhotoEditorView(post: <#Post#>, selectedImages: <#Binding<[UIImage]>#>, selectedItem: <#Binding<[PhotosPickerItem]>#>)
//    }
//}
