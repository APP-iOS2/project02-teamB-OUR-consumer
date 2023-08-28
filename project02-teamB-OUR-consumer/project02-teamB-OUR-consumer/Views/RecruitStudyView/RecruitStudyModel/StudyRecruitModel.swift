//
//  StudyRecruitModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/24.
//

import Foundation
import SwiftUI

struct StudyRecruitModel {
    var id: String = UUID().uuidString
    var creator: String
    var studyTitle: String
    var startAt: Date
    var dueAt: Date
    var description: String
    var isOnline: Bool
    var isOffline: Bool
    var locationName: String // 이름
    var reportCount: Int // 신고 횟수
    var studyImagePath: String
    var studyCount: Int
    var studyCoordinates: [Double]
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 M월 dd일 HH:mm"
        return formatter
    }()
    
    var startDate: String {
        return StudyRecruitModel.dateFormatter.string(from: startAt)
    }
    
    var dueDate: String {
        return StudyRecruitModel.dateFormatter.string(from: dueAt)
    }
    
}
