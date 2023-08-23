//
//  Comment.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/23.
//

import Foundation

struct Comment {
    var id: UUID = UUID()
    var postID: String
    var userID: String
    var uniqueID: String
    var commentID: String
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
}
