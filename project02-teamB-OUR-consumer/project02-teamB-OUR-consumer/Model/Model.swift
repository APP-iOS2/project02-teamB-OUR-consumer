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
        case follow, like, comment, studyJoinRequest, studyJoinApproval
    }

    let type: NotificationType
    let text: String
    let date: Date // 알림 시간
    let imageURL: String? // 게시물 이미지 URL ( 알림 게시물 사진 가져오기 )
}
