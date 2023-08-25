//
//  MyMainProfileEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/22.
//

import SwiftUI

struct MyMainProfileEditView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var image: Image = Image("OUR_Logo")
    @State var username: String
//    @State var profileMessage: String
    @State var showModal: Bool = false
    @State var showImagePicker: Bool = false
    @State var showCamera: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            showModal = true
                        } label: {
                            ZStack(alignment: .bottomTrailing) {
                                image
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(60)
                            
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(mainColor) // 이미지 색상 설정
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2) // 원형 보더 설정
                                    )
                            }
                            .padding(.vertical)
                        }
                        Spacer()
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("이름")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.vertical, 4)
                            
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                            .overlay {
                                TextField("이름을 입력해주세요.", text: $username)
                                    .padding()
                                
                                    
                            }
                            .frame(height: 50)
                    }
                    .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("자기소개")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.vertical, 4)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                            .overlay {
                                TextEditor(text: $username)
                                    .padding()
                            }
                            .frame(minHeight: 300)
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.backward")
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO: 프로필 편집
                } label: {
                    Text("완료")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(mainColor)
                        .cornerRadius(5)
                }
                .buttonStyle(.plain)
            }
        })
        .sheet(isPresented: $showModal) {
            CameraORImageModalView(showModal: $showModal) { form in
                switch form {
                case .camera:
                    showModal = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showCamera = true
                    }
                case .picker:
                    showModal = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showImagePicker = true
                    }
                }
            }
            .presentationDetents([.height(120), .height(120)])
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(isPresented: $showImagePicker) { uiImage in
                let convertedImage = Image(uiImage: uiImage)
                image = convertedImage
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraView(isPresented: $showImagePicker) { uiImage in
                let convertedImage = Image(uiImage: uiImage)
                image = convertedImage
            }
        }
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyMainProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyMainProfileEditView(username: "하이")
        }
    }
}
