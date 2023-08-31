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
