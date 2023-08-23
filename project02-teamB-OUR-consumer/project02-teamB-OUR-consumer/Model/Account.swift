//
//  Account.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/23.
//

import Foundation

struct Account {
    var id: UUID = UUID()
    var name: String
    var profileImg: [String]
    var uniqueID: String // firebase연동전 임시 부여한 고유아이디
    var userID: String
    var numberOfPosts: Int
    var numberOfFollowrs: Int
    var numberOfFollowing: Int
    var numberOfComments: Int
    var profileMessage: String
//    var isFollow: Bool
}
