//
//  StudyListView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/22.
//

import SwiftUI

enum StudyList: String, CaseIterable, Identifiable {
    var id: Self { self }
    case allList = "전체보기"
    case onlineList = "온라인"
    case offlineList = "오프라인"
}

struct StudyListView: View {
    
    @ObservedObject var studyStore = StudyStore()
    
    @State var isOnline: Bool = false
    @State private var selectedArray: StudyList = .allList
    @State var menuTitle: String = "정렬"
    
    var body: some View {
        NavigationStack {
            
            HStack {
                Spacer()
                Picker(selection: $selectedArray) {
                    ForEach(StudyList.allCases) { value in
                        Text(value.rawValue).tag(value)
                            .font(.caption)
                    }
                } label: {
                    Text("정렬기준")
                }
                .accentColor(.gray)
                
                //                Menu(menuTitle) {
                //                    Button {
                //                        selectedArray = .allList
                //                        menuTitle = "전체보기"
                //                    } label: {
                //                        Text("전체보기")
                //                    }
                //                    Button {
                //                        selectedArray = .offlineList
                //                        menuTitle = "비대면 스터디"
                //                    } label: {
                //                        Text("비대면 스터디")
                //                    }
                //                    Button {
                //                        selectedArray = .onlineList
                //                        menuTitle = "대면 스터디"
                //                    } label: {
                //                        Text("대면 스터디")
                //                    }
                //                }
                //                .font(.callout)
                //                .padding()
                
            }
            
            NavigationLink {
                Text("넘어갑니다")
            } label: {
                ScrollView {
                    if selectedArray == .allList {
                        ForEach(studyStore.sortedStudy()) { study in
                            StudyListItemView(study: study)
                        }
                    } else if selectedArray == .onlineList {
                        ForEach(studyStore.sortedOnlineStudy()) { study in
                            StudyListItemView(study: study)
                        }
                    } else {
                        ForEach(studyStore.sortedOfflineStudy()) { study in
                            StudyListItemView(study: study)
                        }
                    }
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
