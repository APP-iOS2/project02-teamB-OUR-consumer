//
//  NotificationDTO.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation

struct NotificationDTO: Identifiable,Codable{
    let id: ID
    let userId: ID
    let type: String
    let content: String
    let isRead: Bool
    let createdDate: Date // 알림 시간
}
