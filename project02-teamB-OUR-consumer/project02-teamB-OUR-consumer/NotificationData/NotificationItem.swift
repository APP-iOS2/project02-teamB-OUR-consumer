//
//  Model.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation


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