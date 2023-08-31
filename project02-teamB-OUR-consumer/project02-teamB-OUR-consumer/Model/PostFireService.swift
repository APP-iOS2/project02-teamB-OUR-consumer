





import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift



class PostFireService {
    private let db = Firestore.firestore()
    
    /// 로그인한 유저의 UID  Get
    static func getCurrentUserUID() -> String? {
        return UserDefaults.standard.string(forKey: Keys.userId.rawValue)
    }
    
    /// 로그인한 유저의 팔로워 목록 가져오기
    func fetchFollowerUIDs(for currentUserUID: String, completion: @escaping ([String]?) -> ()) {
        db.collection("follow")
            .document(currentUserUID)
            .getDocument { (document, error) in
                if let error {
                    print("Error getting follower document: \(error)")
                } else {
                    print("FetchFollowerUID \(String(describing: document?.documentID))")
                    if let document = document {
                        do {
                            let ids = try document.data(as: FollowerData.self)
                            completion(ids.follower)
                            print("Followers Count: \(ids.follower)")
                        } catch {
                            print("do catch error\(error)")
                        }
                    }
                }
            }
    }
    
    /// 로그인한 유저의 팔로워들의 게시물만 가져옴
    func fetchPosts(for followerUIDs: [String], path: String, amount: Int, completion: @escaping ([Post]) -> ()) {
        db.collection("\(path)")
            .whereField("creator", in: followerUIDs)
            .order(by: "createdAt", descending: true)
            .limit(to: amount)
            .getDocuments { (querySnapshot, error) in
                do {
                    if let error = error {
                        print("Error loadFeed: \(error)")
                    } else {
                        print("FetchPosts querySnapshot: \(String(describing: querySnapshot))")
                        var feeds: [Post] = []
                        for document in querySnapshot!.documents {
                            let feed = try document.data(as: Post.self)
                            feeds.append(feed)
                        }
                        completion(feeds)
                        print("Feeds Count: \(feeds.count)")
                    }
                } catch {
                    print("Fetchfeeds: \(error)")
                }
            }
    }
    
    func getPostInfo(post: Post, completion: @escaping (PostModel) -> ()) {
//        print("작성자 \(post.creator)")
        getUserInfo(userId: post.creator) { creator in
            self.isLikedPost(post: post) { bool in
                self.getLikedUser(post: post) { users in
                    let postModel = PostModel(
                        creator: creator ?? User(name: "", email: ""),
                        privateSetting: post.privateSetting,
                        content: post.content,
                        createdAt: post.createdAt,
                        location: post.location,
                        postImagePath: post.postImagePath,
                        reportCount: post.reportCount,
                        numberOfLike: post.like?.count ?? 0 ,
                        isLiked: bool,
                        likedUsers: users
                    )
                    completion(postModel)
                    print("포스트 모델: \(postModel)")
                }
            }
        }
    }
    
    func writeComment(content: String, postId: String, completion: @escaping (Bool) -> ()) {
//        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return }
        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        
        let postComment = PostComment(userId: userId, content: content)
        
        do {
            try db.collection("posts").document(postId).collection("comments").addDocument(from: postComment)
            completion(true)
        } catch {
            print("Error writeComment")
            completion(false)
        }
    }
    
    func getLikedUser(post: Post, completion: @escaping ([User]) -> ()) {
        var likedUser: [User] = []
        getUserInfo(userIds: post.like ?? [""]) { users in
//            print("유저들\(users)")
            likedUser = users.compactMap { $0 }
            completion(likedUser)
//            print("좋아요 한사람들\(likedUser)")
        }
    }
    
    func isLikedPost(post: Post, completion: @escaping (Bool) -> ()) {
        guard let postId = post.id else {
            completion(false)
            return
        }
//        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return }
        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"

        db.collection("posts").document(postId).getDocument { (document, error) in
            if let error = error {
                print("Error checking if post is liked: \(error)")
                completion(false)
            } else if let postData = document?.data(),
                      let likedUserIds = postData["like"] as? [String] {
                completion(likedUserIds.contains(userId))
            } else {
                completion(false)
            }
        }
    }
    
    /// 이 게시물이 내 게시물인지
    func isMyFeed(post: PostModel) -> Bool {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return false }
        
        if post.creator.id == userId {
            return true
        } else {
            return true
        }
    }
    
    func likePost(postID: String) {
        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"

        let likeCollectionRef = db.collection("posts").document(postID)

        likeCollectionRef.getDocument { (document, error) in
            if let error = error {
                print("Error checking likes: \(error)")
            } else if let document = document {
                if var likes = document.data()?["like"] as? [String] {
                    if likes.contains(userId) {
                        // 이미 좋아요를 눌렀을 경우, userId를 배열에서 삭제
                        likes.removeAll(where: { $0 == userId })
                    } else {
                        // 좋아요를 누르지 않았을 경우, userId를 배열에 추가
                        likes.append(userId)
                    }
                    likeCollectionRef.updateData([
                        "like": likes
                    ]) { error in
                        if let error = error {
                            print("Error updating likes: \(error)")
                        } else {
                            print("Updated likes")
                        }
                    }
                } else {
                    // like 필드가 존재하지 않을 경우, 새로운 배열 생성 후 userId 추가
                    let newLikes = [userId]
                    likeCollectionRef.updateData([
                        "like": newLikes
                    ]) { error in
                        if let error = error {
                            print("Error creating likes: \(error)")
                        } else {
                            print("Created likes")
                        }
                    }
                }
            }
        }
    }

    
    func getUserInfo(userId: String, completion: @escaping (User?) -> ()) {
        db.collection("users").document(userId).getDocument(as: User.self) { result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Error decoding users: \(error)")
                completion(nil)
            }
        }
    }
    
    func getUserInfo(userIds: [String], completion: @escaping ([User?]) -> ()) {
        guard !userIds.isEmpty else {
            completion([]) // 빈 배열 반환
            return
        }
        
        var members: [User] = []
        for userId in userIds {
            db.collection("users").document(userId).getDocument(as: User.self) { result in
                switch result {
                case .success(let response):
                    members.append(response)
                case .failure(let error):
                    print("Error decoding users: \(error)")
                }
                
                // 모든 클로저가 완료되었을 때만 호출
                if members.count == userIds.count {
                    completion(members)
                }
            }
        }
    }
}
