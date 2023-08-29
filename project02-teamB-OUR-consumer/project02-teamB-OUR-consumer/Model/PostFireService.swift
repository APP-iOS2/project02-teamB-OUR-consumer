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
    func fetchPosts(for followerUIDs: [String], path: String, amount: Int, completion: @escaping ([PostModel]) -> ()) {
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
                        var feeds: [PostModel] = []
                        for document in querySnapshot!.documents {
                            let feed = try document.data(as: PostModel.self)
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
    
    /// 이 게시물이 내 게시물인지
    func isMyFeed(post: PostModel) -> Bool {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return false }
        
        if post.creator == userId {
            return true
        } else {
            return true
        }
    }
    
    /// 좋아요 기능
    func likePost(postID: String) {
//        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else { return }
        let userId = "eYebZXFIGGQFqYt1fI4v4M3efSv2"
        
        do {
            let likedUser: LikedUsers = LikedUsers(userID: userId)
            try db.collection("posts").document(postID).collection("like").document(userId).setData(from: likedUser)
            print("좋아요 저장")
        }
        catch {
            print(error)
        }
    }
    
    func getUserInfo(userId: String, completion: @escaping (User?) -> Void) {
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
}
