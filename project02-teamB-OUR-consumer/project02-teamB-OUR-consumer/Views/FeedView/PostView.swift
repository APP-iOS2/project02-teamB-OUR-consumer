//
//  PostView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct PostView: View {
    
    @ObservedObject var post: FeedStore
    
    @State var isSpreadBtn: Bool = false
    @State var lineLimitNumber: Int = 2
    
    @State var likeCount: Int = 0
    @State var commentCount: Int = 0
    @State var rePostCount: Int = 0
    
    var body: some View {
        VStack {
            // 어씽크이미지로 수정
            AsyncImage(url: URL(string: "https://isplus.com/data/isp/image/2023/08/06/isp20230806000272.600x.0.jpeg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
                
            VStack(alignment: .leading) {
                HStack(alignment: .bottom, spacing: 10) {
                    Text("\(post.content)")
                        .font(.system(size: 16))
                        .lineLimit(lineLimitNumber)
                    Button {
                        isSpreadBtn.toggle()
                        lineLimitNumber = isSpreadBtn ? 10 : 2
                    } label: {
                        Text("\(isSpreadBtn ? "접기" : "더보기")")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                HStack() {
                    Spacer()
                    Text("좋아요 \(post.numberOfLike)")
                        
                    Text("댓글 \(post.numberOfComments)")
                    Text("퍼감 \(post.numberOfRepost)")
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding()
            }
        }
        
        
    }
}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostView(post: FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, postImageString: "postImg2", content: "축구...어렵네..."))
        }
    }
}
