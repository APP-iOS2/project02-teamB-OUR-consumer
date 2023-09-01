//
//  MyBoardView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct MyBoardView: View {
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    @State private var isShowingPostOptionSheet: Bool = false
    @State private var isScrapFeed: Bool = false
    @State private var isShowingModifyDetailView: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(postViewModel.posts) { post in
                        if (post.creator == "9ZGLxCgsBDdFFwGgezBH6FXnXAx2") {
                            VStack {
                                HStack {
                                    PostUserView(post: post, postViewModel: postViewModel, isShowingSheet: .constant(false))
                                        
                                    Button {
                                        isShowingPostOptionSheet.toggle()
                                    } label: {
                                        Image(systemName: "ellipsis")
                                            .padding(2)
                                    }
                                    .foregroundColor(.gray)
                                }
                                .padding()
                                PostView(post: post, postViewModel: postViewModel)
                                
                                PostButtonView(post: post, postViewModel: postViewModel, isScrapFeed: $isScrapFeed)
                                
                                Divider()
                                    .frame(height: 4)
                                    .overlay((Color("FeedViewDividerColor")))
                            }
                            .sheet(isPresented: $isShowingPostOptionSheet) {
                                PostOptionView(post: post, isShowingPostOptionSheet: $isShowingPostOptionSheet, isShowingModifyDetailView: $isShowingModifyDetailView)
                                                .presentationDetents([.height(220), .height(220)])
                            }
                            .sheet(isPresented: $isShowingModifyDetailView) {
                                PostModifyDetailView(post: post, postViewModel: postViewModel, isShowingModifyDetailView: $isShowingModifyDetailView)
                            }
                        } else {
//                            Text("게시물 X")
                            // 여기말고 사용자가 작성한 게시물 아이디 받아와서 처리
                        }
                    }
                }
                .onAppear{
                    postViewModel.fetchPostForCurrentUserFollower(limit: 3)
                }
                .refreshable {
                    postViewModel.fetchPostForCurrentUserFollower(limit: 3)
                }
            }
        }
    }
}

struct MyBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MyBoardView()
            .environmentObject(UserViewModel())
    }
}
