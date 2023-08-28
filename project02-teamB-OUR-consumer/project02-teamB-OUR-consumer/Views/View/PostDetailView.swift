//
//  PostDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct PostDetailView: View {
    var idStore: IdStore
    var postData: PostData = PostData()
    
    var body: some View {

        VStack {
            HStack {
                Button {
                    
                } label: {
                    HStack {
                        Image("\(idStore.profileImgString)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(idStore.name)")
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
                    Text("축구... 어렵네...")
                }
                .padding()
                
                HStack() {
                    Button {
                        // 좋아요 버튼
                    } label: {
                        Text("좋아요 100")
                    }
                    Spacer()
                    Button {
                        // 댓글 버튼
                    } label: {
                        Text("댓글 5")
                    }
                    Button {
                        // 퍼감 버튼
                    } label: {
                        Text("퍼감 2")
                    }
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
            }
            HStack(spacing: 75) {
                Button {
                    // 좋아요 버튼
                } label: {
                    Image(systemName: "hand.thumbsup")
                }
                NavigationLink {
                    PostDetailView(idStore: idStore)
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
                if idStore.userID == comment.postId {
                    CommentView(comment: comment)
                }
            }
            
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(idStore: IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.", isFollow: false))
    }
}
