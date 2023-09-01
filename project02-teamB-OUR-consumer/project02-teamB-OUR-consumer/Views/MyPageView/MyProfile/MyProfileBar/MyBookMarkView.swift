//
//  MyBookMarkView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct MyBookMarkView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var studyViewModel: StudyViewModel
    @EnvironmentObject var userViewModel: UserViewModel

    @State var navigate: Bool = false
    @State var searchText: String = ""
    @State var isOnline: Bool = false
    @State private var selectedArray: StudyList = .allList

    
    var body: some View {
        NavigationStack {
            if !studyViewModel.studyArray.filter({ study in
                isBookmarkedStudy(studyID: study.id ?? "")
            }).isEmpty {
            List {
                    ForEach(studyViewModel.studyArray.filter { study in
                        isBookmarkedStudy(studyID: study.id ?? "")
                    }) { study in
                        NavigationLink(destination: {
                            
                            StudyDetailView(viewModel: studyViewModel, study: study, isSavedBookmark: isBookmarkedStudy(studyID: study.id ?? ""))
                        }, label: {
                            StudyListItemView(isSavedBookmark: isBookmarkedStudy(studyID: study.id ?? ""), study: study)
                        })
                    }
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("북마크한 스터디")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.backward")
            })

            } else {
                Text("북마크된 내용이 없습니다.")
            }
        }
        .onAppear {
            studyViewModel.fetchStudy()
            guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
                return
            }
            userViewModel.fetchUser(userId: userId)
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

struct MyBookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookMarkView()
            .environmentObject(UserViewModel())
            .environmentObject(StudyViewModel())
    }
}
