//
//  AlarmFireStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/23.
//

import Foundation
import Firebase
import FirebaseFirestore


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
    
    init(){
        
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
        guard var dto = notification.asDictionary else { return }
        
        if let _ = dto["createdDate"]  {
            dto["createdDate"] = date
        }
        
        ref = db.collection("\(path)").addDocument(data: dto) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document NotificationDTO added with ID: \(self.ref!.documentID)")
                completion(self.ref!.documentID)
            }
        }
    }
    
    
    /// Notification DB에서 fetch 하기
    /// - Parameters:
    ///   - path: notification path
    ///   - completion: 모델 가져와서 뷰에 전달 역할
    func read(path: String = "notification", completion: @escaping ([String],[NotificationDTO]) -> ()) {
        db.collection("\(path)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let documentsID = querySnapshot!.documents.map{ $0.documentID }
                
                let notifications = querySnapshot!.documents.compactMap{
                    let data: [String: Any] = $0.data()
                    return data.decodeDTO()
                }
                completion(documentsID,notifications)
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
    func update(){
        
    }
    
}
