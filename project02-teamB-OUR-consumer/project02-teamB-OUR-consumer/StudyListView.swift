//
//  StudyListView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/22.
//

import SwiftUI

struct Study: Identifiable {
    var id: UUID = UUID()
    var imageURL: URL
    var title: String
    var date: String
    var location: String
    var currentMemberCount: Int
    var totalMemberCount: Int
}

class StudyStore: ObservableObject {
    @Published var studyArray: [Study] = []
    
    init() {
        studyArray = [
            Study(imageURL: URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuIT6b%2FbtrpDLcBnAW%2FFX4WsB9SKTiCxZlreaDjM0%2Fimg.png")!, title: "강남역에서 2시간 빡코딩해요!", date: "8월 25일 금 19:00", location: "강남역 스타벅스", currentMemberCount: 1, totalMemberCount: 10),
            Study(imageURL: URL(string: "https://i0.wp.com/sharehows.com/wp-content/uploads/2017/06/자소설닷컴.png?fit=500%2C500&ssl=1")!, title: "자소설닷컴이 주최하는 무료 자소서 첨삭 스터디", date: "8월 31일 ~ 10월 25일 매주 토요일 오전 10시", location: "서울 강남구 봉은사로 230 ", currentMemberCount: 2, totalMemberCount: 10),
            
        ]
    }
}

struct StudyListView: View {
    
    @ObservedObject var studyStore = StudyStore()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(studyStore.studyArray) { study in
                    StudyListItemView(study: study)
                }
            }
            .listStyle(.plain)
            .navigationTitle("스터디 모임")
        }
    }
}

struct StudyListView_Previews: PreviewProvider {
    static var previews: some View {
        StudyListView()
    }
}
