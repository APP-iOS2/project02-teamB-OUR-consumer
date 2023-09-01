//
//  PostButtonView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct PostButtonView: View {
    var post: Post
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @State var isShowingCommentSheet: Bool = false
    @State var isShowingScrapSheet: Bool = false
    @State var isShowingShareSheet: Bool = false
    
    @Binding var isScrapFeed: Bool
    
    var body: some View {
        HStack(spacing: 75) {
            Button {
                // 좋아요 버튼
                postViewModel.likePost(postID: post.id ?? "")
                postModel.isLiked.toggle()
                if postModel.isLiked {
                    postModel.numberOfLike += 1
                } else {
                    postModel.numberOfLike -= 1
                }
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
            postViewModel.getPost(of: post)
        }
    }
}

struct PostButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostButtonView(post: Post.samplePost, isScrapFeed: .constant(false))
                .environmentObject(PostViewModel())
        }
    }
}
