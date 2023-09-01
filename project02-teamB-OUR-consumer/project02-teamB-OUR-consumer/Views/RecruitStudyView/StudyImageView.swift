//
//  StudyImageView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/23.
//


import SwiftUI
import PhotosUI

struct StudyImageView: View {
    
//    @StateObject var viewModel: StudyRecruitStore
    @EnvironmentObject var viewModel: StudyRecruitStore
    @State private var openPhoto = false
    @State private var selectedImages: [UIImage] = []
    
    @Binding var selectedItem: [PhotosPickerItem]
    @State var imageDataArray: [Data] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("사진 선택")
                .font(.system(.title3, weight: .semibold))
            if !imageDataArray.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(imageDataArray.indices, id: \.self) { imageData in
                            if let uiimage = UIImage(data: imageDataArray[imageData]) {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 170, height: 170)
                                    .overlay(
                                        Button(action: {
                                            print("사진삭제")
                                            imageDataArray.remove(at: imageData)
                                            selectedItem.remove(at: imageData)
                                        }, label: {
                                            Image(systemName: "trash.slash.fill")
                                                .foregroundColor(.red)
                                                .font(.system(.title2))
                                                .padding()
                                        })
                                    )
                            }
                        }
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Image(systemName: "plus")
                                .foregroundColor(.gray)
                                .font(.system(size: 40, weight: .thin))
                                .padding(40)
                                .frame(width: 170, height: 170)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        }
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

struct StudyImageView_Previews: PreviewProvider {
    static var previews: some View {
        StudyImageView(selectedItem: .constant([PhotosPickerItem]()))
            .environmentObject(StudyRecruitStore())
    }
}
