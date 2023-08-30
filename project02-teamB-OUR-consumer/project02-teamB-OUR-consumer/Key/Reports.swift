//
//  Reports.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 29.08.23.
//

import Foundation

enum Report: Int {
    case insultsAndSlander
    case spam
    case misinformation
    case explicitContent
    
    static var reasons: [Report] {
        return [.insultsAndSlander, .spam, .misinformation, .explicitContent]
    }
    
    static func getReport(for value: Report) -> String {
        switch value {
        case .insultsAndSlander:
            return "욕설 및 비방"
        case .spam:
            return "스팸성"
        case .misinformation:
            return "잘못된 정보"
        case .explicitContent:
            return "선정적 표현"
        }
    }
    
    func getReport(for value: Int) -> Report? {
        return Report(rawValue: value)
    }
    
    func getReason(for value: Int) -> String {
        switch value {
        case 0:
            return "욕설 및 비방"
        case 1:
            return "스팸성"
        case 2:
            return "잘못된 정보"
        case 3:
            return "선정적 표현"
        default:
            return "기타"
        }
    }
}
