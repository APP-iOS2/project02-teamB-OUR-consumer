//
//  PostDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct PostDetailView: View {
    
    var post: FeedStore
    var postData: PostData = PostData()
    @ObservedObject var idData: IdData

    @Binding var isLikeButton: Bool
    
    var body: some View {
        ForEach(idData.idStore) { user in
            if post.postId == user.userID {
                VStack {
                    HStack {
                        Button {
                            //
                        } label: {
                            HStack {
                                Image("\(user.profileImgString)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: 80, height: 80)
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(user.name)")
                                            .foregroundColor(.black)
                                            .bold()
                                        Text("following")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                    }
                                    Text("5일 전")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom, spacing: 10) {
                            Text(post.content)
                        }
                        .padding()
                        
                        HStack() {
                            Button {
                                // 좋아요 버튼
                            } label: {
                                Text("좋아요 \(post.numberOfLike)")
                            }
                            Spacer()
                            Button {
                                // 댓글 버튼
                            } label: {
                                Text("댓글 \(post.numberOfComments)")
                            }
                            Button {
                                // 퍼감 버튼
                            } label: {
                                Text("퍼감 \(post.numberOfRepost)")
                            }
                        }
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                    }
                    HStack(spacing: 75) {
                        Button {
                            // 좋아요 버튼
                            isLikeButton.toggle()
                        } label: {
                            isLikeButton ? Image(systemName: "hand.thumbsup.fill") : Image(systemName: "hand.thumbsup")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.left")
                        }
                        Button {
                            // 퍼감 버튼
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                        Button {
                            // 공유 버튼
                        } label: {
                            Image(systemName: "arrowshape.turn.up.right")
                        }
                    }
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(hex: 0x090580))
                    .padding()
                    
                    ForEach(postData.postCommentStore) { comment in
                        if user.userID == comment.postId {
                            CommentView(comment: comment)
                        }
                    }
                    
                }
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, content: "축구...어렵네..."), idData: IdData(), isLikeButton: .constant(false))
    }
}
