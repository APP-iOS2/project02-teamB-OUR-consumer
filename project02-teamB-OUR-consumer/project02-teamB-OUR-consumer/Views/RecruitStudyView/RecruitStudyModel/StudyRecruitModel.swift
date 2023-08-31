//
//  StudyRecruitModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/24.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift


struct StudyRecruitModel: Codable, Identifiable {
    //    var id: String = UUID().uuidString

    // 초기화를 시키지않고 옵셔널 형식을 쓰는 이유 -> 서버에서 데이터를 받아올때 없는 필드가 있어도 런타임에러가 나지 않는다.
    
    @DocumentID var id: String?
    var creator: String?    //스터디 만든 유저ID
    var studyTitle: String? //스터디 제목
    var startAt: String?    //스터디 시작일
    var dueAt: String?      //모집 마감일
    var description: String?    //스터디 내용
    var isOnline: Bool?         //온,오프라인 여부
    var locationName: String? // 스터디 위치명
    var studyImagePath: [String]?
    var studyCount: Int?
    var studyCoordinates: [Double]? //스터디 위치
    var currentMemberIds =  [String]()     //스터디 참여인원
    var createdAt: String = Date().dateToString()           //생성일자
    
    
    enum CodingKeys: String, CodingKey {
        case creator = "creatorId"
        case studyTitle = "title"
        case startAt = "studyDate"
        case dueAt = "deadline"
        case description
        case isOnline
        case locationName
        case studyImagePath = "imageString"
        case studyCount = "totalMemberCount"
        case studyCoordinates = "locationCoordinate"
        case currentMemberIds
        case createdAt
    }
    
}

extension Date {
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 M월 dd일 HH:mm"
        return formatter.string(from: self)
    }
}

//struct StudyDㅇㅇTO: Identifiable, Codable {
//    // study Id => 추후 documentId로 바꿀 수도 있음
//    @DocumentID var id: String?
//    // study 배경 Image
//    var imageString: String?            //배열로 변경해달라고 해야할듯
//    // study를 만든 사람의 id
//    var creatorId: String
//    // study 제목
//    var title: String
//    // study 설명
//    var description: String
//    // study 하는 날짜 (1회성)
//    var studyDate: String
//    // study원 모집 마감하는 날
//    var deadline: String
//    var locationName: String?
//    // geopoint => codable 안되어서 double,double로 줘야함
//    var locationCoordinate: [Double]?
//    var isOnline: Bool
////    var linkString: String?                 //
////    var currentMemberIds: [String]          // 등록시에는 필요없음.
//    var totalMemberCount: Int
//    // timestamp => coable 안되어서 string으로 줘야 함
//    var createdAt: String
////    var reportReason: [String]?
////    var reportUserId: [String]?
//}
