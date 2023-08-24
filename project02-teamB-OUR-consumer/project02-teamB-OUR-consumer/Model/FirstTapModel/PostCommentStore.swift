//
//  CommentStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import Foundation

class PostCommentStore: ObservableObject, Identifiable {
    var id: UUID = UUID()
    var postId: String
    var userId: String
    var content: String
    var createdAt: Double = Date().timeIntervalSince1970
    
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
    init(id: UUID, postId: String, userId: String, content: String, createdAt: Double) {
        self.id = id
        self.postId = postId
        self.userId = userId
        self.content = content
        self.createdAt = createdAt
    }

}
