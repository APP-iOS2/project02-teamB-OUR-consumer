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
    
    @EnvironmentObject var studyViewModel: StudyViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var navigate: Bool = false
    @State var searchText: String = ""
    @State var isOnline: Bool = false
    @State private var selectedArray: StudyList = .allList
    
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
            }
            
            List {
                
                ForEach(studyViewModel.sortedStudy(sorted: selectedArray)) { study in
                    NavigationLink(destination: {
                        
                        StudyDetailView(viewModel: studyViewModel, study: study, isSavedBookmark: isBookmarkedStudy(studyID: study.id ?? ""))
                    }, label: {
                        StudyListItemView(isSavedBookmark: isBookmarkedStudy(studyID: study.id ?? ""), study: study)
                    })
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("스터디 모임")
            .onAppear {
                studyViewModel.fetchStudy()
                guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
                    return
                }
                userViewModel.fetchUser(userId: userId)
            }
            .refreshable {
                studyViewModel.fetchStudy()
                guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
                    return
                }
                userViewModel.fetchUser(userId: userId)
            }
        }
    }
    func isBookmarkedStudy(studyID: String) -> Bool {
        guard let studyIDs = userViewModel.user?.savedStudyIDs else { return false }
        if studyIDs.contains(studyID) {
            return true
        } else {
            return false
        }
    }
}

struct StudyListView_Previews: PreviewProvider {
    static var previews: some View {
        StudyListView()
            .environmentObject(UserViewModel())
            .environmentObject(StudyViewModel())
    }
}
