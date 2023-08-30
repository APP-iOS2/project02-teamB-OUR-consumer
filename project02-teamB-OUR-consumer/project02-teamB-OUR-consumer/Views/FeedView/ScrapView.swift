//
//  ScrapView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct ScrapView: View {
    var post: FeedStore
    @Binding var isShowingScrapSheet: Bool
    @Binding var isScrapFeed: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                // 퍼가기 기능 실행
                // 퍼가기 완료 알림!
                isScrapFeed.toggle()
                isShowingScrapSheet.toggle()
                
            } label: {
                VStack(alignment: .leading) {
                    Label("퍼가기", systemImage: "arrow.2.squarepath")
                        .font(.headline)
                    Text("\(post.postId) 님의 업데이트가 다른 사람들의 홈에 표시되게 합니다.")
                        .font(.subheadline)
                }
                .foregroundColor(Color.gray)
            }
        }
    }
}

struct ScrapView_Previews: PreviewProvider {
    static var previews: some View {
        ScrapView(post: FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, postImageString: "postImg", content: "축구...어렵네..."), isShowingScrapSheet: .constant(false), isScrapFeed: .constant(false))
    }
}
