//
//  PostModifyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/28.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct PostModifyDetailView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    var post: Post
    @EnvironmentObject var postViewModel: PostViewModel
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    @Binding var isShowingModifyDetailView: Bool
    @State private var tempContent: String = ""
    @State var isAlert: Bool = false
    
    @State var selectedImages: [UIImage] = []
    @State var selectedItem: [PhotosPickerItem] = []
    
    @State var privacySetting: Bool = false
    @State var locationAddress: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack(alignment: .leading) {
                    PostRecruitPrivateSettingView(privacySetting: $privacySetting)
                    PostRecruitLocationView(locationAddress: $locationAddress)
                }
                TextEditor(text: $postViewModel.postModel.content)
                    .frame(minHeight:350, maxHeight:350)
                    .buttonBorderShape(.roundedRectangle)
                    .border(Color.secondary)
                
                PostModifyDetailPhotoEditorView(selectedImages: $selectedImages, selectedItem: $selectedItem)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // 완료
                        // 수정된 데이터를 넣어줘야함
                        isAlert = true
                        
                        isShowingModifyDetailView.toggle()
                    } label: {
                        Text("완료")
                    }
                    .disabled(postViewModel.postModel.content.isEmpty)

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //취소
//                        isShowingModifyDetailView.toggle()
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
            }
            .padding()
            .navigationTitle("게시물 수정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            
            .alert("피드", isPresented: $isAlert) {
               
                Button("등록" ,role: .destructive) {
                    // 수정된 사항 뷰모델에 적용시키는 기능 넣기

                    dismiss()
                }
                Button("취소" ,role: .cancel) {
                    isAlert = false
                }
            } message: {
                Text("수정하시겠습니까?")
            }
        }
    }
}

struct PostModifyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostModifyDetailView(post: Post.samplePost, isShowingModifyDetailView: .constant(true))
                .environmentObject(PostViewModel())
        }
    }
}
