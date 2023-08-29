//
//  FeedView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var postData: PostData = PostData()
    @State private var isShowingSheet: Bool = false
    @State private var isShowingPostModifySheet: Bool = false
    @State private var isScrapFeed: Bool = false
    @State private var isShowingModifyDetailView: Bool = false
    var userId: String = "leeseungjun"
    
    var body: some View {
        ForEach(postData.postStore) { post in
            VStack {
                HStack {
                    PostUserView(post: post, isShowingSheet: $isShowingSheet)
                    //임시로 넣은 이승준계정 접속 일때만 수정 삭제 가능하게
                    if post.postId == userId {
                        Button {
                            isShowingPostModifySheet.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .padding(2)
                        }
                        .foregroundColor(.gray)
                        // 중복으로 3개 나 나오니까 로그인한 아이디랑 게시물 아이디랑 같을때만 버튼 사용하게
                        .navigationDestination(isPresented: $isShowingModifyDetailView) {
                            PostModifyDetailView(post: post, isShowingModifyDetailView: $isShowingModifyDetailView)
                        }
                    }
                }
                PostView(post: post)
                
                PostButtonView(post: post, postData: postData, isScrapFeed: $isScrapFeed)
                
                Divider()
                    .frame(height: 4)
                    .overlay((Color("FeedViewDividerColor")))
                
            }
            .padding()
            // 수정, 삭제 버튼 시트
            .sheet(isPresented: $isShowingPostModifySheet) {
                PostModifyView(post: post, isShowingPostModifySheet: $isShowingPostModifySheet, isShowingModifyDetailView: $isShowingModifyDetailView)
                    .presentationDetents([.height(220), .height(220)])
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
