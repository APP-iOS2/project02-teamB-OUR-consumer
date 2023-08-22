//
//  StudyListView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/22.
//

import SwiftUI

enum StudyList: String, CaseIterable, Identifiable {
    var id: Self { self }
    case allList
    case onlineList
    case offlineList
}

struct StudyListView: View {
    
    @ObservedObject var studyStore = StudyStore()
    
    @State var isOnline: Bool = false
    @State private var selectedArray: StudyList = .allList
    
    var body: some View {
        NavigationStack {
            
            HStack {
                Picker(selection: $selectedArray) {
                    Text("전체보기").tag(StudyList.allList)
                    Text("대면 스터디").tag(StudyList.offlineList)
                    Text("비대면 스터디").tag(StudyList.onlineList)
                } label: {
                    Text("정렬기준")
                }
                .foregroundColor(.white)
                .background(.gray)
                
                Spacer()
            }
            .padding()

            
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
