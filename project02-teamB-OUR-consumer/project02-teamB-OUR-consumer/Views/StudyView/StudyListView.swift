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
    
    @StateObject var userViewModel = UserViewModel()
    
    @State var navigate: Bool = false
    @State var searchText: String = ""
    @State var isOnline: Bool = false
    @State private var selectedArray: StudyList = .allList
    @State var isSavedBookmark: Bool = false
    
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
                        StudyDetailView(viewModel: studyViewModel, study: study, isSavedBookmark: $isSavedBookmark)
                    }, label: {
                        StudyListItemView(userViewModel: userViewModel, isSavedBookmark: isSavedBookmark, study: study)
                    })
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("스터디 모임")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                     //   SearchView()
                    } label: {
                        Label("검색", systemImage: "magnifyingglass")
                            .foregroundColor(.black)
                    }

                }
            }
            .onAppear {
                studyViewModel.fetchStudy()
                userViewModel.fetchUser(userId: "9ZGLxCgsBDdFFwGgezBH6FXnXAx2")
            }
        }
    }
}

struct StudyListView_Previews: PreviewProvider {
    static var previews: some View {
        StudyListView()
    }
}
