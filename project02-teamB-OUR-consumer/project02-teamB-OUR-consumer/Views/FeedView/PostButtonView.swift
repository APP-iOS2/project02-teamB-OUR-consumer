//
//  PostButtonView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct PostButtonView: View {
    var post: Post
    
    @StateObject var postViewModel: PostViewModel
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @State var isShowingCommentSheet: Bool = false
    @State var isShowingScrapSheet: Bool = false
    @State var isShowingShareSheet: Bool = false
    
    @Binding var isScrapFeed: Bool
    
    @StateObject var idData: IdData = IdData()
    var feed: FeedStore = FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, postImageString: "postImg", content: "축구...어렵네...")
    
    var body: some View {
        HStack(spacing: 75) {
            Button {
                // 좋아요 버튼
                postViewModel.likePost(postID: post.id ?? "")
                postModel.isLiked.toggle()
                print("\(postModel.isLiked)")

            } label: {
                postModel.isLiked ? Image(systemName: "hand.thumbsup.fill") : Image(systemName: "hand.thumbsup")
            }
            Button {
                isShowingCommentSheet.toggle()
            } label: {
                Image(systemName: "bubble.left")
            }
            Button {
                isShowingScrapSheet.toggle()
            } label: {
                Image(systemName: "arrow.2.squarepath")
            }
            // 쉐어링크 수정
            ShareLink(item: post.content) {
                Label("", systemImage: "arrowshape.turn.up.right")
            }
        }
        .font(.title2)
        .bold()
        .foregroundColor(Color(hex: 0x090580))
        .padding()
        // 댓글 시트
        .sheet(isPresented: $isShowingCommentSheet) {
            CommentView(post: post)
        }
        // 퍼가기 시트
        .sheet(isPresented: $isShowingScrapSheet) {
            ScrapView(post: post, isShowingScrapSheet: $isShowingScrapSheet, isScrapFeed: $isScrapFeed)
                .presentationDetents([.height(180), .height(180)])
        }
        .onAppear {
            postViewModel.getPost(of: post) { postModel in
                self.postModel = postModel
            }
        }
    }
}

struct PostButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostButtonView(post: Post.samplePost, postViewModel: PostViewModel(), isScrapFeed: .constant(false))
        }
    }
}
