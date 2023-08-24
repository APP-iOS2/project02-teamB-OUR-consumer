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
        FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, content: "축구...어렵네..."),
        FeedStore(id: UUID(), postId: "kimjongchan", numberOfComments: 2, numberOfLike: 10, numberOfRepost: 5, content: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    ]
    
    var postCommentStore: [PostCommentStore] = [
        PostCommentStore(id: UUID(), postId: "leeseungjun", userId: "kimtuna", content: "축구가 어렵나?", createdAt: Date().timeIntervalSince1970),
        PostCommentStore(id: UUID(), postId: "leeseungjun", userId: "jeonghandoo", content: "그럼 쉽냐?", createdAt: Date().timeIntervalSince1970),
        PostCommentStore(id: UUID(), postId: "leeseungjun", userId: "kimjongchan", content: "쉽지않지", createdAt: Date().timeIntervalSince1970),
        PostCommentStore(id: UUID(), postId: "leeseungjun", userId: "leeseungjun", content: "다들 조용!!!!!", createdAt: Date().timeIntervalSince1970),
        
        PostCommentStore(id: UUID(), postId: "kimjongchan", userId: "jeonghandoo", content: "왜 웃어?", createdAt: Date().timeIntervalSince1970),
        PostCommentStore(id: UUID(), postId: "kimjongchan", userId: "leeseungjun", content: "?", createdAt: Date().timeIntervalSince1970),

    ]
    
    func pressLikeButton(post: FeedStore) {
//        if postStore.contains(post)
    }
    
    // 댓글 추가!
    func addComment(postId: String, userId: String, content: String) {
        var commentNewData: PostCommentStore =  PostCommentStore(id: UUID(), postId: postId, userId: userId, content: content, createdAt: Date().timeIntervalSince1970)
        postCommentStore.append(commentNewData)
    }
}
