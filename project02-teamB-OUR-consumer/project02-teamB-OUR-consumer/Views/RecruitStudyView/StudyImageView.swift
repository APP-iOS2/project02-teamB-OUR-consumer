//
//  StudyImageView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/23.
//


import SwiftUI
import PhotosUI

struct StudyImageView: View {
    
    @StateObject var viewModel: StudyRecruitStore
    @State private var openPhoto = false
    @State private var selectedImages: [UIImage] = []
    
    @State var imageData: Data?
    @Binding var selectedItem: PhotosPickerItem?
    
    var body: some View {
        VStack(alignment: .leading) {
            if selectedItem != nil { // 사진이 선택되었다면..
                Text("사진을 선택해주세요.")
                    .font(.system(.title2))
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                    //                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                        Text("사진 수정하기")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .background(mainColor)
                            .cornerRadius(5)
                    }
                }
            } else { // 선택 사진이 없을경우
                Text("사진을 선택해주세요.")
                    .font(.system(.title2))
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .font(.system(size: 40, weight: .thin))
                        .padding(40)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
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

//struct StudyImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyImageView(viewModel: <#StudyRecruitStore#>)
//    }
//}
