//
//  MyMainDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/09/01.
//

import SwiftUI


struct MyMainDetailView: View {
    
    @State private var currentTab: Int = 0
    @State private var isMyProfile: Bool = false
    @State private var isFollowing: Bool = true
    
    @ObservedObject var studyViewModel: StudyViewModel = StudyViewModel()
    @ObservedObject var resumeViewModel: ResumeViewModel = ResumeViewModel()
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    
    @EnvironmentObject var myViewModel: UserViewModel
    let userId: String
    
    //MARK: 팔로우 하고 있으면 팔로잉 (팔로잉 누르면 취소 - alert)
    var body: some View {
        VStack {
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
        .onAppear {
            print("왜 호출안댐?")
            isFollowingUser()
            userViewModel.fetchUser(userId: userId)
            resumeViewModel.fetchResume(userId: userId)
        }
        .refreshable {
            userViewModel.fetchUser(userId: userId)
            resumeViewModel.fetchResume(userId: userId)
        }
    }
    
    private func isFollowingUser() {
        guard let userFollowingList = userViewModel.user?.following else { return isFollowing = false }
        if userFollowingList.contains(where: { user in
            user == userId
        }) {
            isFollowing = true
        } else {
            isFollowing = false
        }
        print("isFollowing \(isFollowing)")
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

struct MyMainDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyMainDetailView(userId: "BMTtH2JFcPNPiofzyzMI5TcJn")
        }
    }
}
