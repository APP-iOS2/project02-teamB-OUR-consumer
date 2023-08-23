//
//  Model.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation


//id: UUID
//userId: Int (User의 id와 연결)
//type: String (알림 타입 [좋아요, 팔로잉,댓글 ... ])
//content: String (알림 내용)
//isRead: Bool (읽음여부)
//createdDate: Date (알림생성일)
//

//serverModel

typealias ID = String

struct NotificationItem: Identifiable{
    let id: ID
    let user: User
    let type: NotificationType
    let content: String //
    var isRead: Bool
    var imageURL: String?
    let createdDate: Date // 알림 시간
}



////TODO: - TestModel 추후 변경
//struct User: Identifiable {
//    let id: String = UUID().uuidString
//    let name: String
//    let email: String
//    let profileImage: String?
//    let profileMessage: String?
//}
