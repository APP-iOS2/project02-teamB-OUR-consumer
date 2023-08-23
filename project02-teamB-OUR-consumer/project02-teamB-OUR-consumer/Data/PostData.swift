//
//  PostData.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import Foundation

class PostData: ObservableObject {
    var id: UUID = UUID()
    @Published var postStore: [FeedStore] = [
        FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, content: "축구...어렵네...")
    ]
    
    var postCommentStore: [PostCommentStore] = [
        PostCommentStore(id: UUID(), postId: "leeseungjun", userId: "kimtuna", content: "축구가 어렵나?", createdDate: Date()),
        PostCommentStore(id: UUID(), postId: "leeseungjun", userId: "jeonghandoo", content: "그럼 쉽냐?", createdDate: Date()),
        PostCommentStore(id: UUID(), postId: "leeseungjun", userId: "kimjongchan", content: "쉽지않지", createdDate: Date())
    ]
}
