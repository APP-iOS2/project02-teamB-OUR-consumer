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
    
    @Binding var selectedItem: [PhotosPickerItem]
    @State var imageDataArray: [Data] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("사진을 선택해주세요.")
                .font(.system(.title2))
            if !imageDataArray.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(imageDataArray, id: \.self) { imageData in
                            if let uiimage = UIImage(data: imageData) {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .frame(width: 170, height: 170)
                            }
                        }
                    }
                }
                HStack(spacing: 10) {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("사진 수정하기")
                            .frame(maxWidth: .infinity, minHeight: 35)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .background(mainColor)
                            .cornerRadius(5)
                    }
                    Button {
                        print("사진 삭제")
                        selectedItem = []
                    } label: {
                        Text("사진 삭제하기")
                            .frame(maxWidth: .infinity, minHeight: 35)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .background(mainColor)
                            .cornerRadius(5)
                    }
                    
                }
            }
            else {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .font(.system(size: 40, weight: .thin))
                        .padding(40)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
            }
        }
        .onChange(of: selectedItem) { newValue in
            imageDataArray.removeAll()
            for item in newValue {
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            self.imageDataArray.append(data)
                        } else {
                            print("Data is nil")
                        }
                    case .failure(let failure):
                        fatalError("\(failure)")
                    }
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
