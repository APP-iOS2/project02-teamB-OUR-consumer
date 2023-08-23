//
//  ScrapView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct ScrapView: View {
    var post: FeedStore
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .font(.title2)
                    VStack(alignment: .leading) {
                        Text("생각을 덧붙여 퍼가기")
                            .font(.headline)
                        Text("\(post.postId) 님의 업데이트에 덧붙여서 새 업데이트를 씁니다.")
                            .font(.subheadline)
                    }
                }
                .padding()
                .foregroundColor(Color.gray)
            }
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.title2)
                    VStack(alignment: .leading) {
                        Text("퍼가기")
                            .font(.headline)
                        Text("\(post.postId) 님의 업데이트가 다른 사람들의 홈에 표시되게 합니다.")
                            .font(.subheadline)
                    }
                }
                .padding()
                .foregroundColor(Color.gray)
            }
        }
    }
}

struct ScrapView_Previews: PreviewProvider {
    static var previews: some View {
        ScrapView(post: FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, content: "축구...어렵네..."))
    }
}
