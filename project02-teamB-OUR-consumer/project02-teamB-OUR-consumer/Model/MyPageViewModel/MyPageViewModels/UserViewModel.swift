//
//  UserViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이희찬 on 2023/08/26.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth

class UserManager {

    let myViewModel: UserViewModel
    let id: String
    
    init(myViewModel: UserViewModel, id: String) {
        self.myViewModel = myViewModel
        self.id = id
    }
    
    func getUserViewModel() -> UserViewModel {
        if id == Auth.auth().currentUser?.uid {
            return myViewModel
        } else {
            return UserViewModel(id: id)
        }
    }
}


class UserViewModel: ObservableObject {
    
    @Published var user: User = User.defaultUser
    
    
    private var db = Firestore.firestore()
    
    init(id: String) {
        fetchUser(userId: id)
    }

    // Create
    func createUser(user: User) {
        do {
            let _ = try db.collection("users").addDocument(from: user)
        } catch let error {
            print("Error creating user: \(error)")
        }
    }
    
    // Read
    func fetchUser(userId: String) {
        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let result = Result {
                    try document.data(as: User.self)
                }
                switch result {
                    case .success(let user):
                        self.user = user
                    case .failure(let error):
                        print("Error decoding user: \(error)")
                }
            }
        }
    }
    
    // Update
    func updateUser(user: User) {
        if let userId = user.id {
            do {
                try db.collection("users").document(userId).setData(from: user)
            } catch let error {
                print("Error updating user: \(error)")
            }
        }
    }
}

extension UserViewModel {
    func followUser(targetUserId: String) {
   
            db.collection("users").document("BMTtH2JFcPNPiofzyzMI5TcJn1S2").updateData([
                "following": FieldValue.arrayUnion([targetUserId])
            ])
            
            
            db.collection("users").document(targetUserId).updateData([
                "follower": FieldValue.arrayUnion(["BMTtH2JFcPNPiofzyzMI5TcJn1S2"])
            ])
        
            user.following?.append(targetUserId)
    }
    
    func unfollowUser(targetUserId: String) {
            db.collection("users").document("BMTtH2JFcPNPiofzyzMI5TcJn1S2").updateData([
                "following": FieldValue.arrayRemove([targetUserId])
            ])
            
            db.collection("users").document(targetUserId).updateData([
                "follower": FieldValue.arrayRemove(["BMTtH2JFcPNPiofzyzMI5TcJn1S2"])
            ])
        
        user.following?.removeAll(where: { id in
            return id == targetUserId
        })
    }
    
    func fetchFollowDetails(userId: String, follow: FollowType, completion: @escaping ([User]) -> Void) {
           db.collection("users").document(userId).getDocument { (document, error) in
               if let data = document?.data(), let followingIds = data[follow.rawValue] as? [String] {
                   self.fetchUsersDetails(userIds: followingIds, completion: completion)
               } else {
                   completion([])
               }
           }
       }
    
    private func fetchUsersDetails(userIds: [String], completion: @escaping ([User]) -> Void) {
        if userIds.count == 0 { return completion([]) }

        db.collection("users").whereField(FieldPath.documentID(), in: userIds).getDocuments { (querySnapshot, error) in
            if let documents = querySnapshot?.documents {
                let users = documents.compactMap { document -> User? in
                    try? document.data(as: User.self)
                }
                completion(users)
            } else {
                completion([])
            }
        }
    }
}

enum FollowType: String {
    case following
    case follower
}

extension UserViewModel {
    func uploadProfileImage(_ image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(false)
            return
        }

        guard let userId = user.id else {
            completion(false)
            return
        }

        let storageRef = Storage.storage().reference().child("profileImages/\(userId).jpg")

        // Upload the file to the path "profileImages/userId.jpg"
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error)")
                completion(false)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Error download URL: \(error?.localizedDescription ?? "No error description.")")
                    completion(false)
                    return
                }
    
                self.user.profileImage = downloadURL.absoluteString
            }
        }
    }
    
    func fetchProfileImage(userId: String, completion: @escaping (URL?) -> Void) {
        let storageRef = Storage.storage().reference().child("profileImages/\(userId).jpg")
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error fetching profile image: \(error)")
                completion(nil)
            } else {
                completion(url)
            }
        }
    }

}
