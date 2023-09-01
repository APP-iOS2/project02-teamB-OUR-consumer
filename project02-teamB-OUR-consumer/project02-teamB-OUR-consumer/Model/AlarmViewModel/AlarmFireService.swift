//
//  AlarmFireStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

enum REF: String{
    case Announcement
    case comments
    case follow
    case posts
    case studyGrops
    case studyGroupComments
    case users
    case notification
}


class AlarmFireService {
    
    let db = Firestore.firestore()

    var ref: DocumentReference?
    
    var notificationChangeRef: ListenerRegistration?
    
    var userId: ID = ""
    
    init(){
        
        let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) ?? ""
        print("userId : \(userId)")
        self.userId = userId
    }
    
    
    func observingNotification(path: String = "notification", completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        notificationChangeRef = db.collection("\(path)").addSnapshotListener(completion)
    }

    
    /// Create Notification
    /// - Parameters:
    ///   - notification: 알림 DTO 객체
    ///   - path: 저장 위치
    ///   - completion: completion Block
    func create(send notification: NotificationDTO,
                path: String = "notification",
                completion: @escaping (String) -> () )
    {
        let date = notification.timestamp
 
        do{
            _ = try db.collection("\(path)").addDocument( from: notification ) { error in
                if let error = error {
                    print("신규추가 중 에러 : \(error.localizedDescription)")
                    
                } else {
                    print("추가완료")
                }
            }
        }catch{
            
        }
    }
    
    // Read
    func fetchUser(userId: String, completion: @escaping (User) -> ()) {
        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let result = Result {
                    try document.data(as: User.self)
                }
                switch result {
                case .success(let user):
                    completion(user)
                case .failure(let error):
                    print("Error decoding user: \(error)")
                }
            }
        }
    }
    
    
    /// Notification DB에서 fetch 하기
    /// - Parameters:
    ///   - path: notification path
    ///   - completion: 모델 가져와서 뷰에 전달 역할
    func read(path: String = "notification",followingsIDs: [String] ,completion: @escaping (Result<[NotificationDTO],Error>) -> ()) {
        
        let query: Query
        if followingsIDs.isEmpty{
            query = db.collection("\(path)")
        }else{
            query = db.collection("\(path)").whereField("userId", in: followingsIDs)
        }
        
        query.getDocuments{ querySnapshot,err in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            if let snapshot = querySnapshot {
                let dto = snapshot.documents.compactMap { snap in try? snap.data(as: NotificationDTO.self)}
                completion(.success(dto))
            }
        }
    }
    
    
    /// 여러개의 DocumentID 의 notification 삭제하기
    /// - Parameters:
    ///   - path: Notification 경로
    ///   - ids: 여러개의 Document IDs
    ///   - completion: 콜백
    func delete(path: String = "notification",
                ids: [String],
                completion: @escaping (String) -> ())
    {
        ids.forEach { id in
            db.collection("\(path)").document(id).delete(completion: { vs in
                completion("\(id)")
            })
        }
    }
    
    
    /// 한개 DocumentID  Notification 삭제하기
    /// - Parameters:
    ///   - path: Notification 경로
    ///   - id: Document ID
    ///   - completion: 콜백함수
    func delete(path: String = "notification",
                id: String,
                completion: @escaping (String) -> ())
    {
        db.collection("\(path)").document(id).delete(completion: { vs in
            completion("\(id)")
        })
    }
    
    
    // update
    func update(_ path: String = "notification",
                id: String,
                completion: @escaping (Error?) -> ())
    {
        db.collection("\(path)").document(id).updateData([ "isRead" : true ], completion: { error in
            if let error{
                completion(error)
            }else{
                completion(nil)
            }
        })
    }
    
    // update
    func update(_ path: String = "notification",
                ids: [String],
                completion: @escaping (Error?) -> ())
    {
        
        ids.forEach { id in
            db.collection("\(path)").document(id).updateData([ "isRead" : true ], completion: { error in
                if let error{
                    completion(error)
                }else{
                    completion(nil)
                }
            })
        }
    }
}
