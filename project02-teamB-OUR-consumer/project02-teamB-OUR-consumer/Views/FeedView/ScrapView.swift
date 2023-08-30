//
//  ScrapView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct ScrapView: View {
    var post: Post
    @State var postModel: PostModel = PostModel.samplePostModel
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
                    Text("\(postModel.creator.name) 님의 업데이트가 다른 사람들의 홈에 표시되게 합니다.")
                        .font(.subheadline)
                }
                .foregroundColor(Color.gray)
            }
        }
    }
}

struct ScrapView_Previews: PreviewProvider {
    static var previews: some View {
        ScrapView(post: Post.samplePost, isShowingScrapSheet: .constant(false), isScrapFeed: .constant(false))
    }
}
