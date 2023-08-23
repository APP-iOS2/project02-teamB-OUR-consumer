//
//  PostView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct PostView: View {
    var idData: IdData
    var postData: PostData
    
    @State var isSpreadBtn: Bool = false
    @State var lineLimitNumber: Int = 2
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {     // 포스트데이터를 포이치안에 넣고 같은 아이디만 아이디데이터에서 나오게?
                    ForEach(idData.idStore) { user in
                        HStack {
                            Button {
                                isShowingSheet.toggle()
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
                        
                        // 포스트 데이터에서 받아와야함
                        VStack(alignment: .leading) {
                            HStack(alignment: .bottom, spacing: 10) {
                                Text("축구... 어렵네...")
                                    .lineLimit(lineLimitNumber)
                                Button {
                                    isSpreadBtn.toggle()
                                    lineLimitNumber = isSpreadBtn ? 10 : 2
                                } label: {
                                    Text("\(isSpreadBtn ? "접기" : "더보기")")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            
                            HStack() {
                                Spacer()
                                Button {
                                    // 좋아요 버튼
                                } label: {
                                    Text("좋아요 100")
                                }
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
                        
                        
                        // Comment
                        HStack {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .background(.gray)
                                .clipShape(Circle())
                                .frame(width: 45, height: 45)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(postData.postCommentStore[0].userId)")
                                    HStack {
                                        Text("\(postData.postCommentStore[0].createdDate)")
                                        Text("Reply")
                                    }
                                    .font(.footnote)
                                    .foregroundColor(Color(hex: 0x090580))
                                }
                                HStack {
                                    Text("\(postData.postCommentStore[0].content)")
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color("FeedViewBackgroundColor"))
                        
                        HStack(spacing: 75) {
                            Button {
                                // 좋아요 버튼
                            } label: {
                                Image(systemName: "hand.thumbsup")
                            }
                            NavigationLink {
                                PostDetailView(idStore: user)
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
                        
                        .sheet(isPresented: $isShowingSheet) {
                            SheetView(idStore: user)
                                .presentationDetents([.medium, .medium])
                        }
                    }
                    VStack(alignment: .leading) {
                        RecommendFriendView(idStore: IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.", isFollow: false), idData: idData)
                    }
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostView(idData: IdData(), postData: PostData(), isShowingSheet: .constant(false))
        }
    }
}
