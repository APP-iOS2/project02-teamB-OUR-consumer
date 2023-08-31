//
//  PostDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct CommentView: View {
    
    var post: Post
    @State var postModel: PostModel = PostModel.samplePostModel
    
    @State var commentString: String = ""
    @State var isReviseComment: Bool = false
    
    var body: some View {
//        ForEach(idData.idStore) { user in
//            if post.postId == user.userID {
//                VStack {
//                    HStack{
//                        Text("댓글")
//                            .padding()
//                            .font(.headline)
//                        Spacer()
//                    }
//                    Divider()
//                    ScrollView {
//                        ForEach(postData.postCommentStore) { comment in
//                            if user.userID == comment.postId {
//                                CommentDetailView(comment: comment, userId: user.userID, isModifyComment: $isReviseComment)
//                            }
//                        }
//                    }
//                    Spacer()
//                    HStack {
//                        // 로그인된 사용자 임시로 "leeseungjun"
//                        Image(idData.idStore[0].profileImgString)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .clipShape(Circle())
//                            .frame(width: 45, height: 45)
//                        TextField("\(idData.idStore[0].userID) (으)로 댓글 달기", text: $commentString, axis: .vertical)
//                            .padding()
//                            .background {
//                                RoundedRectangle(cornerRadius: 15, style: .continuous)
//                                    .fill(Color.gray.opacity(0.1))
//                            }
//
//                        Button {
//                            // 댓글 정보 전송
//                                if isReviseComment == true {
//                                    postData.modifyComment(postId: post.postId, userId: idData.idStore[0].userID, content: commentString)
//                                    commentString = ""
//                                } else {
//                                    postData.addComment(postId: post.postId, userId: idData.idStore[0].userID, content: commentString)
//                                    commentString = ""
//                                }
//                        } label: {
//                            isReviseComment ? Text("수정") : Text("게시")
//                        }
//                    }
//                    .padding()
//                }
        Text("")
            VStack {
                Text("댓글")
                    .padding()
                    .font(.headline)
                Divider()
                ScrollView {
                    ForEach(postModel.comment) { comment in
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
                    TextField("\(postModel.creator.name) (으)로 댓글 달기", text: $commentString, axis: .vertical)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.gray.opacity(0.1))
                        }
                    
                    Button {
                        // 댓글 정보 전송
                            if isReviseComment == true {
                                
                                commentString = ""
                            } else {
                                
                                commentString = ""
                            }
                    } label: {
                        isReviseComment ? Text("수정") : Text("게시")
                    }
                }
                .padding()
            }
    }

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommentView(post: Post.samplePost,isReviseComment: false)
        }
    }
}
