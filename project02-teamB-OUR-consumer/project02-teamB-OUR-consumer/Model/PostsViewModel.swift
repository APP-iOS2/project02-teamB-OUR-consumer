//
//  PostsViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by SONYOONHO on 2023/08/29.
//

import Foundation

class PostViewModel: ObservableObject {
    private var fireStoreService: PostFireService
    
    @Published var posts: [PostModel] = []
    
    init(fireStoreService: PostFireService = PostFireService()) {
        self.fireStoreService = fireStoreService
    }
    
    func fetchPostForCurrentUserFollower(limit amount: Int) {
//        guard let currentUserUID = PostFireService.getCurrentUserUID() else {
//            print("Error: current user UID")
//            return
//        }
        let currentUserUID = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        
        fireStoreService.fetchFollowerUIDs(for: currentUserUID) { followerUIDs in
            guard let followerUIDs = followerUIDs else {
                print("Not exist follower")
                return
            }
            
            self.fireStoreService.fetchPosts(for: followerUIDs, path: "posts", amount: 10) { post in
                self.posts = post
            }
        }
    }
    
}
