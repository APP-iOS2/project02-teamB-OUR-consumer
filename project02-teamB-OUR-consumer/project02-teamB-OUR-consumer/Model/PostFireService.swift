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
        var allUIds = followerUIDs
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return }
//        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        allUIds.append(userId)
        let uniqueUIds = Array(Set(allUIds))
        
        db.collection("\(path)")
            .whereField("creator", in: uniqueUIds)
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
                        print("Feeds: \(feeds)")
                    }
                } catch {
                    print("Fetchfeeds: \(error)")
                }
            }
    }
    
    /// 실제로 뷰에서 사용하는 데이터 모델로 변환
    func getPostInfo(post: Post, completion: @escaping (PostModel) -> ()) {
//        print("작성자 \(post.creator)")
        getUserInfo(userId: post.creator) { creator in
            self.isLikedPost(post: post) { bool in
                self.getLikedUser(post: post) { users in
                    self.fetchComments(postId: post.id ?? "") { postComments in
                        let postModel = PostModel(
                            creator: creator ?? User(name: "", email: ""),
                            privateSetting: post.privateSetting,
                            content: post.content,
                            createdAt: post.createdAt,
                            location: post.location,
                            postImagePath: post.postImagePath,
                            reportCount: post.reportCount,
                            numberOfComments: postComments.count,
                            numberOfLike: post.like?.count ?? 0 ,
                            isLiked: bool,
                            comment: postComments,
                            likedUsers: users
                        )
                        completion(postModel)
                        print(postComments.count)
                    }
                }
            }
        }
    }
    
    func writeComment(content: String, postId: String, completion: @escaping (Bool) -> ()) {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return }
//        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        
        let postComment = PostComment(userId: userId, content: content)
        
        do {
            try db.collection("posts").document(postId).collection("comments").addDocument(from: postComment)
            completion(true)
        } catch {
            print("Error writeComment")
            completion(false)
        }
    }
    
    /// 특정 게시물에 좋아요를 누른 사람들의 정보를 User모델 배열로 가져옴
    func getLikedUser(post: Post, completion: @escaping ([User]) -> ()) {
        guard let user = post.like else {
            completion([])
            return
        }
        
        var likedUser: [User] = []
        getUserInfo(userIds: user) { users in
            likedUser = users.compactMap { $0 }
            completion(likedUser)
        }
    }
    
    /// 로그인한 유저가 특정 게시물에 좋아요를 눌렀는지 여부
    func isLikedPost(post: Post, completion: @escaping (Bool) -> ()) {
        guard let postId = post.id else {
            completion(false)
            return
        }
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return }
//        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"

        db.collection("posts").document(postId).getDocument { (document, error) in
            guard let document = document?.data() else {
                completion(false)
                return
            }
            if let error = error {
                print("Error checking if post is liked: \(error)")
                completion(false)
            } else if let likedUserIds = document["like"] as? [String] {
                completion(likedUserIds.contains(userId))
            } else {
                completion(false)
            }
        }
    }
    
    func isMyFeed(post: PostModel) -> Bool {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return false }
        
        if post.creator.id == userId {
            return true
        } else {
            return true
        }
    }
    
    func likePost(postID: String, completion: @escaping (Bool) -> ()) {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return }
//        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        print("포스트ID\(postID)")

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
                            completion(true)
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
                            completion(true)
                        }
                    }
                }
            }
        }
    }

    /// 유저 한명의 정보 가져오기
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
    
    /// 유저 여러명의 정보 가져오기
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
    
    /// 댓글 정보 가져오기
    func fetchComments(postId: String, completion: @escaping ([PostCommentModel]) -> ()) {
        db.collection("posts").document(postId).collection("comments").order(by: "createdAt", descending: false).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching comments: \(error)")
                completion([])
            } else {
                if let querySnapshot {
                    guard !querySnapshot.documents.isEmpty else {
                        completion([])
                        return
                    }
                    var comments: [PostCommentModel] = []
                    for document in querySnapshot.documents {
                        do {
                            let postComment = try document.data(as: PostComment.self)
                            self.getUserInfo(userId: postComment.userId) { user in
                                let postCommentModel = PostCommentModel(user: user!, content: postComment.content, createdAt: postComment.createdAt)
                                comments.append(postCommentModel)
                                if comments.count == querySnapshot.count {
                                    completion(comments)
                                }
                            }
                        } catch {
                            print("FetchComments() Error: \(error)")
                        }
                    }
                } else {
                    completion([])
                }
            }
        }
    }
    
    ///  PostModel에 대한 정보를 새로고침
    func refreshPostModel(postId: String, completion: @escaping (PostModel) -> ()) {
        db.collection("posts").document(postId).getDocument(as: Post.self) { result in
            switch result {
            case .success(let response):
                print(response)
                self.getPostInfo(post: response) { postModel in
                    completion(postModel)
                }
            case .failure(let error):
                print("refreshError: \(error)")
            }
        }
    }
    
    func fetchMyPost(completion: @escaping ([Post]) -> ()) {
                guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return }
//        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        db.collection("posts")
            .whereField("creator", isEqualTo: userId)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("error")
                } else if let querySnapshot = querySnapshot {
                        var posts: [Post] = []
                        for document in querySnapshot.documents {
                            do {
                                let post = try document.data(as: Post.self)
                                posts.append(post)
                            } catch {
                                print("fetchMyPostError: \(error)")
                            }
                        }
                        completion(posts)
                        print("자신의 게시물만 반환 \(posts)")
                }
            }
    }
    
    func reportPost(report: String, postId: String, completion: @escaping () -> ()) {
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }
        
//        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        print(postId)
        
        db.collection("posts").document(postId).updateData([
            "reportCategory": [report],
            "reportId": [userId]
        ]) { error in
            if let error = error {
                print("Error reportPost \(error)")
            } else {
                print("Report Success")
            }
        }
    }
    
    func modifyPosts(post: Post, completion: @escaping (Bool) -> ()) {
        let docRef = db.collection("posts").document(post.id ?? "")
        print("포스트아이디\(String(describing: post.id))")
        
        do {
            try docRef.setData(from: post)
        } catch {
            print(error)
        }
    }
}




