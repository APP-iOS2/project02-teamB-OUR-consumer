//
//  StudyData.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 28.08.23.
//

import Foundation

// DB에 studygroup에 들어갈 study 전체 내용 (올라가고, 받고)
struct Study: Identifiable, Codable {
    // study Id => 추후 documentId로 바꿀 수도 있음
    var id: String = UUID().uuidString
    // study 배경 Image
    var imageString: String?
    // study를 만든 사람의 id
    var creatorId: String
    // study 제목
    var title: String
    // study 설명
    var description: String
    // study 하는 날짜 (1회성)
    var studyDate: String
    // study원 모집 마감하는 날
    var deadline: String
    var locationName: String?
    // geopoint => codable 안되어서 double,double로 줘야함
    var locationCoordinate: [Double]?
    var isOnline: Bool
    var linkString: String?
    var currentMemberIds: [String]
    var totalMemberCount: Int
    // timestamp => coable 안되어서 string으로 줘야 함
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case imageString = "imageString"
        case creatorId = "creatorId"
        case title = "title"
        case description = "description"
        case studyDate = "studyDate"
        case deadline = "deadline"
        case locationName = "locationName"
        case locationCoordinate = "locationCoordinate"
        case isOnline = "isOnline"
        case linkString = "linkString"
        case currentMemberIds = "currentMemberIds"
        case totalMemberCount = "totalMemberCount"
        case createdAt = "createdAt"
    }
}

extension Study {
    static var defaultStudy: Study {
        return Study(creatorId: "BMTtH2JFcPNPiofzyzMI5TcJn1S2", title: "test", description: "testetstseteststsets", studyDate: "2023년 9월 30일", deadline: "2023년 8월 30일", isOnline: false, currentMemberIds: [], totalMemberCount: 4, createdAt: "2023년 8월 23일 오전 12시 0분 0초 UTC+9")
    }
}

struct StudyGroupComment: Identifiable, Codable {
    var id: String = UUID().uuidString
    var userId: String
    var content: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case content = "content"
        case createdAt = "createdAt"
    }
}
