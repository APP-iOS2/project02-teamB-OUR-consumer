//
//  NotificationType.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation


enum NotificationType: String {
    case follow
    case like
    case comment
    
    case studyJoin
    case studyComment
    
    case studyJoinRequest
    case studyJoinApproval
    // case hidden
    case studyReply
    case studyAutoJoin
    case none
    
    typealias Value = String
    
    var content: String {
        switch self {
        case .follow:
            return " 팔로우 하였습니다."
        case .like:
            return " 님이 좋아요를 눌렀습니다."
        case .comment:
            return " 님이 댓글을 남겼습니다."
        case .studyJoin:
            return " 님이 스터디에 참여하였습니다."
        case .studyComment:
            return " 님이 스터디에 댓글을 남겼습니다."
        case .studyJoinRequest:
            return "넌 머여"
        case .studyJoinApproval:
            return "넌 머여"
        case .studyReply:
            return "넌 머여"
        case .studyAutoJoin:
            return "넌 머여"
        case .none:
            return "넌 머여"
        }
    }
    
    var value: Value{
        self.rawValue
    }
    
    func getAccessLevel() -> Access{
        switch self {
        case .follow,.like,.comment:
            return .personal
        case .studyJoinRequest,.studyJoinApproval, .studyReply, .studyAutoJoin, .studyJoin,.studyComment:
            return .public
        case .none:
            return .none
        }
    }
    
    enum Access{
        case `public`
        case `personal`
        case none
    }
}
