//
//  StudyGroup.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/23.
//

import Foundation

struct StudyGroup: Identifiable {
    var id: UUID
    var creator: String
    var studyTitle: String
    var startDate: String
    var description: String
    var isOnline: Bool
    var imageString: [String] // 이거 왜 스트링으로 받아오는지 물어보기(-)
    var members: [Int]
    var memberCount: Int
    var memberTotalCount: Int
    var locationName: String
    var locationCoordinate: String
    var urlString: String
    var createdAt: Date
    var expireDate: Date
}
