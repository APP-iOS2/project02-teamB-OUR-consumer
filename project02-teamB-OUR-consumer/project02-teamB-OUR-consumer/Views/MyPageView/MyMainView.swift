//
//  MyMainView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

let mainColor = Color(hex: "#090580")

struct MyMain: View {
    
    @State private var currentTab: Int = 0
    @State private var isMyProfile: Bool = true
    @State private var isFollowing: Bool = true
    
    @EnvironmentObject var studyViewModel: StudyViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var resumeViewModel: ResumeViewModel
    
    //MARK: 팔로우 하고 있으면 팔로잉 (팔로잉 누르면 취소 - alert)
    var body: some View {
        NavigationStack {
            ScrollView {
                ProfileBar(isMyProfile: $isMyProfile)
                        .padding(.horizontal)

                VStack(alignment: .leading, spacing: 20) {
                    
                    ProfileHeaderView(userViewModel: userViewModel, isMyProfile: $isMyProfile, isFollowing: $isFollowing)
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        Section {
                            switch currentTab {
                            case 0:
                                MyResumeView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile)
                            case 1:
                                MyBoardView()
                            case 2:
                                MyStudyView(studyArray: studyViewModel.studyArray)
                            default:
                                EmptyView()
                            }
                        } header: {
                            MyMainTabBar(currentTab: $currentTab, namespace: Namespace(), tabBarOptions: ["이력서", "게시물", "스터디"])
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .local)
                        .onEnded({ value in
                            if value.translation.width < -50 {
                                leftSwipeAction()
                            }
                            
                            if value.translation.width > 50 {
                                rightSwipeAction()
                            }
                            
                        }))
                    
                    Spacer()
                }
            }
            .padding(.top, 1)
            .navigationTitle("")
        }
        .onAppear(){
            guard let currentUserId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
                return
            }
            resumeViewModel.fetchResume(userId: currentUserId)
        }
        .refreshable {
            guard let currentUserId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
                return
            }
            resumeViewModel.fetchResume(userId: currentUserId)
        }
    }
    
    private func rightSwipeAction() {
        if currentTab > 0 {
            currentTab -= 1
        }
    }
    
    private func leftSwipeAction() {
        if currentTab < 3 {
            currentTab += 1
        }
    }
    
}

struct MyMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyMain()
                .environmentObject(UserViewModel())
                .environmentObject(StudyViewModel())
                .environmentObject(ResumeViewModel())
        }
    }
}
