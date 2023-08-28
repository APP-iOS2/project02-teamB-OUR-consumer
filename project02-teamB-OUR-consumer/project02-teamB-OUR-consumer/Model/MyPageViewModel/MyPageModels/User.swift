import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var profileImage: String?
    var profileMessage: String?
    var follower: [String]?
    var following: [String]?
    
    var numberOfFollower: Int {
        follower?.count ?? 0
    }
    
    var numberOfFollowing: Int {
        following?.count ?? 0
    }
}
