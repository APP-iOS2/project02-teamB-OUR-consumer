//
//  PostButtonView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct PostButtonView: View {
    var post: PostModel
    @ObservedObject var postViewModel: PostViewModel
    
    @State var isLikeButton: Bool = false
    @State var isShowingCommentSheet: Bool = false
    @State var isShowingScrapSheet: Bool = false
    @State var isShowingShareSheet: Bool = false
    
    @Binding var isScrapFeed: Bool
    
    var body: some View {
        HStack(spacing: 75) {
            Button {
                // 좋아요 버튼
                postViewModel.likePost(postID: post.id ?? "")
                isLikeButton.toggle()

            } label: {
                isLikeButton ? Image(systemName: "hand.thumbsup.fill") : Image(systemName: "hand.thumbsup")
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
//        // 댓글 시트
//        .sheet(isPresented: $isShowingCommentSheet) {
//            CommentView(post: post, idData: idData)
//        }
//        // 퍼가기 시트
//        .sheet(isPresented: $isShowingScrapSheet) {
//            ScrapView(post: post, isShowingScrapSheet: $isShowingScrapSheet, isScrapFeed: $isScrapFeed)
//                .presentationDetents([.height(180), .height(180)])
//        }
    }
}

//struct PostButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            PostButtonView(post: PostModel(creator: "qVEfC7VbiZNbPqqcZuNCbHcInHL2", privateSetting: false, content: "Feed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed TestFeed Test", location: "천안", createdAt: "2023/08/29 15:31", feedImagePath: "https://firebasestorage.googleapis.com:443/v0/b/our-app-server.appspot.com/o/FeedPosts%2FdfMFTtvs96wYBH6xAQAs%2F1F89C181-2EA7-4301-9507-B8CFF1B41303.jpeg?alt=media&token=40affd81-d5d2-4a5c-8799-7cebf7f6607f", reportCount: 0), isScrapFeed: .constant(false))
//        }
//    }
//}
