//
//  SampleModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/22.
//

import Foundation

struct Study: Identifiable {
    var id: UUID = UUID()
    var imageURL: URL
    var title: String
    var date: String
    var location: String
    var isOnline: Bool
    var currentMemberCount: Int
    var totalMemberCount: Int
    var createdAt: Double = Date().timeIntervalSince1970
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분 ss초"
        
        let dateCreatedAt = Date(timeIntervalSince1970: createdAt)
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}

class StudyStore: ObservableObject {
    @Published var studyArray: [Study] = []
    

    
    func sortedStudy() -> [Study] {
        let sortedArray = studyArray.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
    
    func sortedOnlineStudy() -> [Study] {
        let sortedArray = studyArray.filter { $0.isOnline }.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
    
    func sortedOfflineStudy() -> [Study] {
        let sortedArray = studyArray.filter { !$0.isOnline }.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
    
    init() {
        studyArray = [
            Study(imageURL: URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuIT6b%2FbtrpDLcBnAW%2FFX4WsB9SKTiCxZlreaDjM0%2Fimg.png")!, title: "강남역에서 2시간 빡코딩해요!", date: "8월 25일 금 오후 7시", location: "강남역 스타벅스", isOnline: false, currentMemberCount: 1, totalMemberCount: 10),
            Study(imageURL: URL(string: "https://i0.wp.com/sharehows.com/wp-content/uploads/2017/06/자소설닷컴.png?fit=500%2C500&ssl=1") ?? URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuIT6b%2FbtrpDLcBnAW%2FFX4WsB9SKTiCxZlreaDjM0%2Fimg.png")!, title: "자소설닷컴이 주최하는 무료 자소서 첨삭 스터디", date: "8월 31일 ~ 10월 25일 매주 토요일 오전 10시", location: "서울 강남구 봉은사로 230 ", isOnline: false, currentMemberCount: 2, totalMemberCount: 10),
            Study(imageURL: URL(string: "https://i0.wp.com/sharehows.com/wp-content/uploads/2017/06/자소설닷컴.png?fit=500%2C500&ssl=1") ?? URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuIT6b%2FbtrpDLcBnAW%2FFX4WsB9SKTiCxZlreaDjM0%2Fimg.png")!, title: "iOS 개발자 면접 스터디 모집", date: "9월 1일 ~ 9월 30일 매주 토 오후 2시", location: "종각역 할리스", isOnline: false, currentMemberCount: 2, totalMemberCount: 5),
            
        ]
    }
}
