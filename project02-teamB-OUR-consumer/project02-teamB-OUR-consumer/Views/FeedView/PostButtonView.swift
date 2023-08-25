//
//  PostButtonView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct PostButtonView: View {
    var post: FeedStore
    @ObservedObject var idData: IdData = IdData()
    @ObservedObject var postData: PostData
    
    @State var isLikeButton: Bool = false
    @State var isShowingCommentSheet: Bool = false
    @State var isShowingScrapSheet: Bool = false
    @State var isShowingShareSheet: Bool = false
    
    var body: some View {
        HStack(spacing: 75) {
            Button {
                // 좋아요 버튼
                isLikeButton.toggle()
                if isLikeButton == true {
                    post.numberOfLike += 1
//                    postData.pressLikeButton(post: post)
                } else {
                    post.numberOfLike -= 1
                }
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
        // 댓글 시트
        .sheet(isPresented: $isShowingCommentSheet) {
            CommentView(post: post, idData: idData)
        }
        // 퍼가기 시트
        .sheet(isPresented: $isShowingScrapSheet) {
            ScrapView(post: post, isShowingScrapSheet: $isShowingScrapSheet)
                .presentationDetents([.height(180), .height(180)])
        }
        .sheet(isPresented: $isShowingShareSheet) {
        }

    }
}

struct PostButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostButtonView(post: FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, content: "축구...어렵네..."), postData: PostData())
        }
    }
}
