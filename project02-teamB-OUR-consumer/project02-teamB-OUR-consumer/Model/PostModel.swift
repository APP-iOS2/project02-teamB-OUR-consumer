//
//  PostModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by SONYOONHO on 2023/08/29.
//

import Foundation
import FirebaseFirestoreSwift

struct PostModel: Codable, Identifiable {
    @DocumentID var id: String?
    var creator: String
//    var numberOfComments: Int
//    var numberOfLike: Int
//    var numberOfRepost: Int
    var privateSetting: Bool
    var content: String
    var createdAt: Double = Date().timeIntervalSince1970
    var location: String
    var feedImagePath: String
    var reportCount: Int
//    var isRepost: Bool

    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}
