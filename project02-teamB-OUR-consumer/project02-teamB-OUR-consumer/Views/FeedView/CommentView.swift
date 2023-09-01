//
//  PostDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct CommentView: View {
    
    var post: Post
    @EnvironmentObject var postViewModel: PostViewModel
    @State var postModel: PostModel = PostModel.samplePostModel
    
    @State var commentString: String = ""
    @State var isReviseComment: Bool = false
    
    var body: some View {
            VStack {
                Text("댓글")
                    .padding()
                    .font(.headline)
                Divider()
                ScrollView {
                    ForEach(postViewModel.postModel.comment) { comment in
                            CommentDetailView(comment: comment, isModifyComment: $isReviseComment)
                        }
                    }
                }
                Spacer()
                HStack {
                    // 로그인된 사용자 임시로 "leeseungjun"
                    Image("OUR_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 45, height: 45)
                    TextField("\(postViewModel.postModel.creator.name) 의 게시물에 댓글 달기", text: $commentString, axis: .vertical)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(Color.gray.opacity(0.1))
                        }
                    
                    Button {
                        // 댓글 정보 전송
                            if isReviseComment == true {
                                
                                commentString = ""
                            } else {
                                postViewModel.writeComment(content: commentString, postId: post.id ?? "")
                                commentString = ""
                            }
                    } label: {
                        isReviseComment ? Text("수정") : Text("게시")
                    }
                }
                .padding()
                .onAppear {
                    postViewModel.getPost(of: post)
                }
            }
    }

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommentView(post: Post.samplePost, isReviseComment: false)
                .environmentObject(PostViewModel())
        }
    }
}
