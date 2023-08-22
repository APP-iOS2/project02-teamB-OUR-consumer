//
//  IdStore.swift
//  HomeTab
//
//  Created by Handoo Jeong on 2023/08/22.
//

import Foundation

class IdStore: ObservableObject {
    var id: UUID = UUID()
    var name: String
    var imgString: String
    var accountID: String
    var numberOfPosts: Int
    var numberOfFollowrs: Int
    var numberOfFollowing: Int
    var briefIntro: String
    
    init(id: UUID, name: String, imgString: String, accountID: String, numberOfPosts: Int, numberOfFollowrs: Int, numberOfFollowing: Int, briefIntro: String) {
        self.id = id
        self.name = name
        self.imgString = imgString
        self.accountID = accountID
        self.numberOfPosts = numberOfPosts
        self.numberOfFollowrs = numberOfFollowrs
        self.numberOfFollowing = numberOfFollowing
        self.briefIntro = briefIntro
    }
}
