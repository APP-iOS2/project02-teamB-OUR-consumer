//
//  FeedView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var postViewModel: PostViewModel
    @State private var postModel: PostModel = PostModel.samplePostModel
    @State private var isShowingSheet: Bool = false
    @State private var isScrapFeed: Bool = false
    
    var body: some View {
        VStack {
            ForEach(postViewModel.posts) { post in
                VStack {
                    PostUserView(post: post, isShowingSheet: $isShowingSheet)
                        .padding()
                    
                    PostView(post: post, isScrapFeed: $isScrapFeed)
                    
                    Divider()
                        .frame(height: 4)
                        .overlay((Color("FeedViewDividerColor")))
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

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .environmentObject(PostViewModel())
    }
}
