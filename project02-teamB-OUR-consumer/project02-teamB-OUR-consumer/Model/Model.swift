//
//  Model.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation



// 알림 항목 모델
struct NotificationItem {
    enum NotificationType {
        case follow, like, studyJoinRequest, studyJoinApproval
    }

    let type: NotificationType
    let text: String
    let date: Date // 알림 시간
}
