//
//  StudyImageView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/23.
//


import SwiftUI
struct StudyImageView: View {
    
    @State private var openPhoto = false
    @State private var selectedImages: [UIImage] = []
    
    var body: some View {
//        NavigationStack {
            VStack(alignment: .leading) {
                Text("사진을 선택해주세요.")
                    .font(.system(.title2))
                
                Button {
                    print("앨범 창 오픈")
                    self.openPhoto = true
                } label: {
                    if selectedImages.isEmpty {
                        Image(systemName: "plus")
                            .foregroundColor(.gray)
                            .font(.system(size: 40, weight: .thin))
                            .padding(40)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 140, height: 140)
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $openPhoto) {
                RecruitImagePicker(selectedImages: $selectedImages)
            }
//        }
    }
}

struct StudyImageView_Previews: PreviewProvider {
    static var previews: some View {
        StudyImageView()
    }
}
