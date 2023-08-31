//
//  FeedDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/30.
//

import SwiftUI

struct FeedDetailView: View {
    
    // 파이어베이스 연결되어 있는 모델
    var post: Post
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    @State private var isShowingSheet: Bool = false
    @State private var isScrapFeed: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                PostUserView(post: post, postViewModel: postViewModel, isShowingSheet: $isShowingSheet)
                    .padding(.leading, 15)
                PostView(post: post, postViewModel: postViewModel)
                PostButtonView(post: post, postViewModel: postViewModel, isScrapFeed: $isScrapFeed)
                CommentView(post: post)
            }
        }
    }
}

struct FeedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailView(post: Post.samplePost)
    }
}
