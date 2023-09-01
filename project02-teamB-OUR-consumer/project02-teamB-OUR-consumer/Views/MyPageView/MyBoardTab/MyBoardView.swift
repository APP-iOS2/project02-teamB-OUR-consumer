//
//  MyBoardView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct MyBoardView: View {
    @StateObject var postViewModel: PostViewModel = PostViewModel()

    @State private var isShowingSheet: Bool = false
    @State private var isShowingPostOptionSheet: Bool = false
    @State private var isScrapFeed: Bool = false
    @State private var isShowingModifyDetailView: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(postViewModel.posts) { post in
                    VStack {
                        PostUserView(post: post, isShowingSheet: $isShowingSheet)
                            .padding()
                        
                        PostView(post: post, isScrapFeed: $isScrapFeed)
                    }
                    Rectangle()
                        .fill(Color("DefaultGray"))

                }
                .onAppear{
                    postViewModel.fetchPostForCurrentUserFollower(limit: 3)
                }
                .refreshable {
                    postViewModel.fetchPostForCurrentUserFollower(limit: 3)
                }
            }
        }
        .onAppear {
            postViewModel.getMyPosts()
        }
    }
}

struct MyBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MyBoardView()
            .environmentObject(UserViewModel())
    }
}
