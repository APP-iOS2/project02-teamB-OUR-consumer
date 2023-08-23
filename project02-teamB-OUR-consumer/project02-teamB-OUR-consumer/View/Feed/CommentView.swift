//
//  CommentView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct CommentView: View {
    var comment: PostCommentStore
    
    var body: some View {
        HStack {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(.gray)
                .clipShape(Circle())
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                HStack {
                    Text("\(comment.userId)")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    HStack {
                        Text("\(comment.createdDate)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .font(.footnote)
//                    .foregroundColor(Color(hex: 0x090580))
                }
                HStack {
                    Text("\(comment.content)")
                        .font(.system(size: 14))
                }
            }
            Spacer()
        }
        .padding()
        .background(Color("FeedViewBackgroundColor"))
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: PostCommentStore(id: UUID(), postId: "leeseungjun", userId: "kimtuna", content: "축구가 어렵나?", createdAt: Date().timeIntervalSince1970))
    }
}
