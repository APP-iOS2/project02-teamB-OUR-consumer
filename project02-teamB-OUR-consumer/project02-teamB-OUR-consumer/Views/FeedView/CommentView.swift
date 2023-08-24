//
//  PostDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct CommentView: View {
    
    var post: FeedStore
    @ObservedObject var postData: PostData = PostData()
    @ObservedObject var idData: IdData
    
    @State var commentString: String = ""
    @Binding var isLikeButton: Bool
    
    var body: some View {
        ForEach(idData.idStore) { user in
            if post.postId == user.userID {
                VStack {
                    Divider()
                    ScrollView {
                        ForEach(postData.postCommentStore) { comment in
                            if user.userID == comment.postId {
                                CommentDetailView(comment: comment, userId: user.userID)
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        Image(user.profileImgString)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 45, height: 45)
                        TextField("\(user.userID) (으)로 댓글 달기", text: $commentString, axis: .vertical)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.gray.opacity(0.1))
                            }
                        
                        Button {
                            // 댓글 정보 전송
                            // 일단 본인 게시물에 댓글 달면 본인 아이디로 들어가게 해놓음
                            postData.addComment(postId: post.postId, userId: user.userID, content: commentString)
                            commentString = ""
                        } label: {
                            Text("게시")
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("댓글")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommentView(post: FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, content: "축구...어렵네..."), idData: IdData(), isLikeButton: .constant(false))
        }
    }
}
