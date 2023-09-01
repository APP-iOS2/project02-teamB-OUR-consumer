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
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    @StateObject var feedStoreViewModel: FeedRecruitStore = FeedRecruitStore()
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    @Binding var isShowingModifyDetailView: Bool
    @State private var tempContent: String = ""
    @State var isAlert: Bool = false
    
    @State var selectedImages: [UIImage] = []
    @State var selectedItem: [PhotosPickerItem] = []
    @State var feedImagePath: [String] = []
    
    @State var privacySetting: Bool = false
    @State var locationAddress: String = ""
    @State var content: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Picker("PrivacySetting", selection: $privacySetting) {
                            Text("Public").tag(PrivacySetting.Public)
                            Text("Private").tag(PrivacySetting.Private)
                        }
                        .pickerStyle(.menu)
                        Spacer()
                    }
                    
                    PostRecruitLocationView(locationAddress: $locationAddress)
                }
                TextEditor(text: $content)
                    .frame(minHeight:350, maxHeight:350)
                    .buttonBorderShape(.roundedRectangle)
                    .border(Color.secondary)
                
                PostModifyDetailPhotoEditorView(post: post, selectedImages: $selectedImages, selectedItem: $selectedItem)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // 완료
                        // 수정된 데이터를 넣어줘야함
                        isAlert = true
                        
                        Task {
                            let modifiedPost = Post(id: post.id, creator: post.creator, privateSetting: privacySetting, content: content, createdAt: post.createdAt, location: locationAddress, postImagePath: post.postImagePath, reportCount: post.reportCount)
                            
                            print("modifiedPost\(modifiedPost)")
                            
                            postViewModel.modifyPosts(post: modifiedPost)
                        }
                    }
                label: {
                    Text("완료")
                }
                .disabled(post.content == content)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //취소
                        isShowingModifyDetailView.toggle()
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
                
            }
        }
        .padding()
        .navigationTitle("게시물 수정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
        .alert("피드", isPresented: $isAlert) {
            
            Button("확인" ,role: .none) {
                isShowingModifyDetailView.toggle()
            }
        } message: {
            Text("수정되었습니다.")
        }
        .onAppear {
            content = post.content
            privacySetting = post.privateSetting
            locationAddress = post.location
            feedImagePath = post.postImagePath
        }
    }
    
    func convertUIImageArrayToStringArray(_ images: [UIImage]) -> [String] {
        var imageStrings: [String] = []
        
        for image in images {
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                let base64String = imageData.base64EncodedString()
                imageStrings.append(base64String)
            }
        }
        
        return imageStrings
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
