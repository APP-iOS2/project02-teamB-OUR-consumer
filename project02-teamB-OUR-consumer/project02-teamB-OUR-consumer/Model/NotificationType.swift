//
//  NotificationType.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation


enum NotificationType: String,Codable {
    case follow
    case like
    case comment
    case studyJoinRequest
    case studyJoinApproval
    // case hidden
    case none
    
    func getAccessLevel() -> Access{
        switch self {
        case .follow,.like,.comment:
            return .public
        case .studyJoinRequest,.studyJoinApproval:
            return .personal
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
