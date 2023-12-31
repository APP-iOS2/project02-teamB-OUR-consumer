


//
//  PostsViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by SONYOONHO on 2023/08/29.
//

import Foundation

class PostViewModel: ObservableObject {
    private var fireStoreService: PostFireService
    
    @Published var posts: [Post] = []
    @Published var postModel: PostModel = PostModel.samplePostModel
    
    init(fireStoreService: PostFireService = PostFireService()) {
        self.fireStoreService = fireStoreService
    }
    
    func fetchPostForCurrentUserFollower(limit amount: Int) {
        
        /// 로그인한 유저의 UID를 가져옴
        guard let currentUserUID = PostFireService.getCurrentUserUID() else {
            print("Error: current user UID")
            return
        }
        
//        let currentUserUID = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        
        fireStoreService.fetchFollowerUIDs(for: currentUserUID) { followerUIDs in
            guard let followerUIDs = followerUIDs else {
                print("Not exist follower")
                return
            }
            
            self.fireStoreService.fetchPosts(for: followerUIDs, path: "posts", amount: amount) { post in
                self.posts = post
            }
        }
    }
    
    func likePost(postID: String) {
        fireStoreService.likePost(postID: postID) { result in
            self.fireStoreService.refreshPostModel(postId: postID) { postModel in
                self.postModel = postModel
                print("PostModel: \(postModel)")
            }
        }
    }
    
    func getPost(of post: Post) {
        fireStoreService.getPostInfo(post: post) { post in
            self.postModel = post
        }
    }
    
    func writeComment(content: String, postId: String) {
        fireStoreService.writeComment(content: content, postId: postId) { success in
            if success {
                self.fireStoreService.refreshPostModel(postId: postId) { postModel in
                    self.postModel = postModel
                    print("PostModel: \(postModel)")
                }
                print("댓글 작성 성공")
            } else {
                print("댓글 작성 실패")
            }
        }
    }
    
    func getMyPosts() {
        fireStoreService.fetchMyPost { posts in
            self.posts = posts
        }
    }
    
    func reportPost(postId: String, report: String) {
        fireStoreService.reportPost(report: report, postId: postId) {
            
        }
    }
    
    func modifyPosts(post: Post) {
        fireStoreService.modifyPosts(post: post) { result in
            print("결과: \(result)")
            
        }
    }
    
}
