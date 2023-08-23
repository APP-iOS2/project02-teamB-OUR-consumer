//
//  IdStore.swift
//  HomeTab
//
//  Created by Handoo Jeong on 2023/08/22.
//

import Foundation

class IdStore: ObservableObject, Identifiable {
    var id: UUID = UUID()
    var name: String
    var profileImg: [String]
    var userID: String
    var numberOfPosts: Int
    var numberOfFollowrs: Int
    var numberOfFollowing: Int
    var numberOfComments: Int
    var profileMessage: String
    var posts: [String]
    var followers: [String]
    var followings: [String]
    var comments: [String]
    
    init(id: UUID, name: String, profileImg: [String], userID: String, numberOfPosts: Int, numberOfFollowrs: Int, numberOfFollowing: Int, numberOfComments: Int, profileMessage: String, posts: [String], followers: [String], followings: [String], comments: [String]) {
        self.id = id
        self.name = name
        self.profileImg = profileImg
        self.userID = userID
        self.numberOfPosts = posts.count
        self.numberOfFollowrs = followers.count
        self.numberOfFollowing = followings.count
        self.numberOfComments = comments.count
        self.profileMessage = profileMessage
        self.posts = posts
        self.followers = followers
        self.followings = followings
        self.comments = comments
    }

}
