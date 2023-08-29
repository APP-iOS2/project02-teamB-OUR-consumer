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
    var startAt: String
    var dueAt: String
    var description: String
    var isOnline: Bool
    var isOffline: Bool
    var locationName: String // 이름
    var reportCount: Int // 신고 횟수
    var studyImagePath: [String]
    var studyCount: Int
    var studyCoordinates: [Double]
}

extension Date {
    func dateToSring() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 M월 dd일 HH:mm"
        return formatter.string(from: self)
    }
}
