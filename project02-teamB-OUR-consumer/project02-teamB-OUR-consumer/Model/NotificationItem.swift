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

enum NotificationType: String,Codable {
    case follow
    case like
    case reply
    case studyJoinRequest
    case studyJoinApproval
}

struct NotificationItem: Identifiable,Codable{
    let id: ID
    let user: User
    let type: NotificationType
    let content: String //
    var isRead: Bool
    let createdDate: Date // 알림 시간
}

struct NotificationDTO: Identifiable,Codable{
    let id: ID
    let userId: ID
    let type: NotificationType
    let content: String
    let isRead: Bool
    let createdDate: Date // 알림 시간
}


//TODO: - TestModel 추후 변경
struct User: Codable{
    let id: ID
    let name: String
}


// 알림 항목 모델
struct NotificationItem2 {
    enum NotificationType {
        case follow, like, studyJoinRequest, studyJoinApproval
    }

    let type: NotificationType
    let text: String
    let date: Date // 알림 시간
}
