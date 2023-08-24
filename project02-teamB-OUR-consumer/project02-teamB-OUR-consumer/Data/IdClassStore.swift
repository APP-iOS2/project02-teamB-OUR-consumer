//
//  IdStore.swift
//  HomeTab
//
//  Created by Handoo Jeong on 2023/08/22.
//

import Foundation

class IdClassStore: ObservableObject {
    var id: UUID = UUID()
    var name: String
    var profileImgString: String
    var userID: String
    var numberOfPosts: Int
    var numberOfFollowrs: Int
    var numberOfFollowing: Int
    var numberOfComments: Int
    var profileMessage: String
    
    init(id: UUID, name: String, profileImgString: String, userID: String, numberOfPosts: Int, numberOfFollowrs: Int, numberOfFollowing: Int, numberOfComments: Int, profileMessage: String) {
        self.id = id
        self.name = name
        self.profileImgString = profileImgString
        self.userID = userID
        self.numberOfPosts = numberOfPosts
        self.numberOfFollowrs = numberOfFollowrs
        self.numberOfFollowing = numberOfFollowing
        self.numberOfComments = numberOfComments
        self.profileMessage = profileMessage
    }
}
