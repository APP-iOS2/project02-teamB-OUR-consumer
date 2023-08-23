//
//  PostStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/23.
//

import Foundation

class PostStore: ObservableObject {
    @Published var post: [Post]
    @Published var postIDForCount: String = "" {
        didSet {
            updateNumberOfComments()
        }
        
    }

    init() {
        self.post = [

        ]
    }
    func addPost(addPostID: String, addUserID: String, addContent: String, numberOfLike: Int, numberOfComment: Int, numberOfRepost: Int) {
        let addPost: Post = Post(postID: addPostID, userID: addUserID, content: addContent, numberOfLike: 0, numberOfComment: 0, numberOfRepost: 0)
        
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
