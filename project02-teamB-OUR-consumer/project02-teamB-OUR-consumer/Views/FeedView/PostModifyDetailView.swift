//
//  PostModifyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/28.
//

import SwiftUI

struct PostModifyDetailView: View {
    
    @ObservedObject var post: FeedStore
    @Binding var isShowingModifyDetailView: Bool
    
    @State private var tempContent: String = ""
    
    var body: some View {
        VStack {
            List {
                Section("게시물 사진") {
                    Image(post.postImageString)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                Section("게시물 내용"){
                    TextField("게시물의 내용을 입력해주세요.", text: $post.content)
                        .font(.system(size: 16))
                    
                }
            }
            .padding()
            .navigationTitle("게시물 수정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
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
    }
}

struct PostModifyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostModifyDetailView(post: FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, postImageString: "postImg2", content: "축구...어렵네..."), isShowingModifyDetailView: .constant(true))
        }
    }
}
