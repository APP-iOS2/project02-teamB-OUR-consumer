//
//  AccountStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/23.
//

import Foundation

class AccountStore {
    
    var account: [Account]

    init() {
        let commentStore = CommentStore()
        var uniqueIDToCheck = ""
        let numberOfComments = commentStore.numberOfCommentOnAccount(forUserID: uniqueIDToCheck)
        
        self.account = [
            Account(name: "이승준", profileImg: ["Jun"], uniqueID: "leeseungjun00001", userID: "leeseungjun", numberOfPosts: 0, numberOfFollowrs: 0, numberOfFollowing: 0, numberOfComments: 0, profileMessage: "안녕하세요. 이승준입니다."),
            Account(name: "정한두", profileImg: ["Doo"], uniqueID: "jeonghandoo00001", userID: "jeonghandoo", numberOfPosts: 0, numberOfFollowrs: 0, numberOfFollowing: 0, numberOfComments: 0, profileMessage: "안녕하세요. 정한두입니다.")
        ]
    }
    
    func addAccount(addName: String, profileImg: [String], uniqueID: String, userID: String, numberOfPosts: Int, numberOfFollowers: Int, numberOfFollowing: Int, numberOfComments: Int, profileMessage: String) {
        let addAccount: Account = Account(name: addName, profileImg: add, uniqueID: <#T##String#>, userID: <#T##String#>, numberOfPosts: <#T##Int#>, numberOfFollowrs: <#T##Int#>, numberOfFollowing: <#T##Int#>, numberOfComments: <#T##Int#>, profileMessage: <#T##String#>)
        
        post.insert(addPost, at: 0)
    }
    
    func updateNumberOfComments() {
        let commentStore = CommentStore()
        let numberOfCommentsOnPost = commentStore.numberOfCommentOnPost(forUserID: postIDForCount)
        
        for index in 0..<post.count {
            if post[index].postID == postIDForCount {
                post[index].numberOfComment = numberOfCommentsOnPost
            }
        }
    }
}
