//
//  NotificationDTO.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct NotificationDTO: Identifiable,Codable{
    @DocumentID var id: ID?
    let userId: ID
    let type: String
    let content: String
    let isRead: Bool
    let createdDate: Date // 알림 시간
    
    var timestamp: Timestamp{
        Timestamp(date: createdDate)
    }
    
    init(id: ID, userId: ID, type: String, content: String, isRead: Bool, createdDate: Date) {
        self.id = id
        self.userId = userId
        self.type = type
        self.content = content
        self.isRead = isRead
        self.createdDate = createdDate
    }
    
    init(id: ID, userId: ID, type: String, content: String, isRead: Bool, createdDate: Timestamp) {
        self.id = id
        self.userId = userId
        self.type = type
        self.content = content
        self.isRead = isRead
        self.createdDate = createdDate.dateValue().toString().toDate()
    }
}

extension NotificationDTO{
    func toDomain(user: User) -> NotificationItem{
        let type = NotificationType(rawValue: self.type) ?? .none
        return NotificationItem(id: self.id ?? "",
                                user: user ,
                                type: type,
                                content: self.content,
                                isRead: self.isRead,
                                imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPvi3WpN86PNtBjUkO1ftQr6Uz7AlzimJicEX67lk9jw&s",
                                createdDate: self.createdDate)
    }
}

extension Dictionary where Key == String{
    
    func decodeDTO() -> NotificationDTO{
        
        let id = self["id"] as? String ?? ""
        let userId = self["userId"] as? String ?? ""
        let type = self["type"] as? String ?? "none"
        let content = self["content"] as? String ?? ""
        let isRead = self["isRead"] as? Bool ?? false
        let createdDate = self["createdDate"] as? Timestamp ?? Timestamp(date: Date())
        
        let date = createdDate.dateValue().toString().toDate()
        
        return NotificationDTO(id: id,
                               userId: userId,
                               type: type,
                               content: content,
                               isRead: isRead,
                               createdDate: date)
    }
    
}


