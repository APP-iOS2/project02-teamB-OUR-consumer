//
//  PostModifyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/28.
//

import SwiftUI

struct PostModifyDetailView: View {
    
    var post: Post
    var postViewModel: PostViewModel
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @Binding var isShowingModifyDetailView: Bool
    
    @State private var tempContent: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("게시물 사진") {
                    if postModel.postImagePath.isEmpty == false {
                        TabView {
                            ForEach(postModel.postImagePath, id: \.self) { imagePath in
                                AsyncImage(url: URL(string: imagePath)) { image in
                                    image
                                        .resizable()
                                        .frame(height: 400)
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 350)
                    }
                }
                Section("게시물 내용"){
                    TextField("게시물의 내용을 입력해주세요.", text: $postModel.content)
                        .font(.system(size: 16))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // 완료
                        // 수정된 데이터를 넣어줘야함
                        isShowingModifyDetailView.toggle()
                    } label: {
                        Text("완료")
                    }

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //취소
                        isShowingModifyDetailView.toggle()
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
        
    }
}

struct PostModifyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostModifyDetailView(post: Post.samplePost, postViewModel: PostViewModel(), isShowingModifyDetailView: .constant(true))
        }
    }
}
