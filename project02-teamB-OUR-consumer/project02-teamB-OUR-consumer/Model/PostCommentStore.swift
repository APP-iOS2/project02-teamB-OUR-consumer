//
//  CommentStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import Foundation

class PostCommentStore: ObservableObject {
    var id: UUID = UUID()
    var postId: String
    var userId: String
    var content: String
    var createdDate: Date
    
    init(id: UUID, postId: String, userId: String, content: String, createdDate: Date) {
        self.id = id
        self.postId = postId
        self.userId = userId
        self.content = content
        self.createdDate = createdDate
    }

}
