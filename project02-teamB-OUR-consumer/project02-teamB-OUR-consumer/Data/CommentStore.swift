//
//  CommentStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/23.
//

import Foundation

class CommentStore {
    var comment: [Comment] = [
        Comment(postID: "leeseungjun00001p00001", userID: "kimtuna", uniqueID: "kimtuna00001", commentID: "kimtuna00001c00001", content: "축구가 어렵나?"),
        Comment(postID: "leeseungjun00001p00001", userID: "jeonghandoo", uniqueID: "jeonghandoo00001", commentID: "jeonghandoo00001c00001", content: "그럼 쉽냐?"),
        Comment(postID: "leeseungjun00001p00001", userID: "kimjongchan", uniqueID: "kimjongchan00001", commentID: "kimjongchan00001c00001", content: "쉽지않지"),
        Comment(postID: "kimjongchan00001p00001", userID: "jeonghandoo", uniqueID: "jeonghandoo00001", commentID: "jeonghandoo00001c00001", content: "왜 웃어?"),
        Comment(postID: "kimjongchan00001p00001", userID: "leeseungjun", uniqueID: "leeseungjun", commentID: "leeseungjun00001c00001", content: "?")
    ]
    
    func numberOfCommentOnPost(forUserID postId: String) -> Int {
        var count = 0
        for comment in comment {
            if comment.postID == postId {
                count += 1
            }
        }
        return count
    }
    
    func numberOfCommentOnAccount(forUserID uniqueID: String) -> Int {
        var count = 0
        for comment in comment {
            if comment.uniqueID == uniqueID {
                count += 1
            }
        }
        return count
    }
}
