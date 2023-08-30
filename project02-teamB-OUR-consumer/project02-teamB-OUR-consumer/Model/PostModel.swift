//
//  PostModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by SONYOONHO on 2023/08/29.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

// 데이터베이스에서 가져오는 모델
struct Post: Codable, Identifiable {
    @DocumentID var id: String?
    var creator: String
    var privateSetting: Bool
    var content: String
    var createdAt: String
    var location: String
    var postImagePath: [String]
    var reportCount: Int
    var isRepost: Bool?
}


struct PostModel: Identifiable {
    var id: String?
    var creator: User
    var privateSetting: Bool
    var content: String
    var createdAt: String
    var location: String
    var postImagePath: [String]
    var reportCount: Int
    var isRepost: Bool?
    var numberOfComments: Int?
    var numberOfLike: Int
    var numberOfRepost: Int?
}

//extension PostModel {
//    static var samplePostModel = PostModel(creator: User.defaultUser, privateSetting: false, content: "", createdAt: "", location: "", postImagePath: [""], reportCount: 0, numberOfLike: 0)
//}

struct FollowerData: Codable {
    let follower: [String]
}

struct LikedUsers: Codable {
    let userID: String
    var createdAt: String
    
    init(userID: String) {
        self.userID = userID
        let timestamp = Timestamp(date: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        self.createdAt = formatter.string(from: timestamp.dateValue())
    }
}
