//
//  StudyData.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 28.08.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// DB에 studygroup에 들어갈 study 전체 내용 (올라가고, 받고)
struct StudyDTO: Identifiable, Codable {
    // study Id => 추후 documentId로 바꿀 수도 있음
    @DocumentID var id: String?
    // study 배경 Image
    var imageString: [String]?
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
    var reportReason: [String]?
    var reportUserId: [String]?
    
    func toStudyDetail(creator: User, currentMembers: [User], comments: [StudyComment], isJoined: Bool) -> StudyDetail {
            return StudyDetail(
                id: self.id ?? UUID().uuidString,
                imageString: self.imageString,
                creator: creator,
                title: self.title,
                description: self.description,
                studyDate: self.studyDate,
                deadline: self.deadline,
                locationName: self.locationName,
                locationCoordinate: self.locationCoordinate,
                isOnline: self.isOnline,
                linkString: self.linkString,
                currentMembers: currentMembers,
                totalMemberCount: self.totalMemberCount,
                comments: comments,
                reportReasons: self.reportReason ?? [],
                reportUserIds: self.reportUserId ?? [],
                isJoined: isJoined
            )
        }
}

extension StudyDTO {
    static var defaultStudy: StudyDTO {
        return StudyDTO(creatorId: "BMTtH2JFcPNPiofzyzMI5TcJn1S2", title: "test", description: "testetstseteststsets", studyDate: "2023년 9월 30일", deadline: "2023년 8월 30일", isOnline: false, currentMemberIds: [], totalMemberCount: 4, createdAt: "2023년 8월 23일 오전 12시 0분 0초 UTC+9")
    }
}

struct StudyCommentDTO: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var content: String
    var createdAt: String
    
    func toStudyComments(user: User) -> StudyComment {
        return StudyComment(
            id: self.id ?? UUID().uuidString,
            user: user,
            content: content,
            createdAt: createdAt
        )
    }
}
