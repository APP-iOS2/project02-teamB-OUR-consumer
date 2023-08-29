//
//  MyMainView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/22.
//

import SwiftUI
import Firebase

// MARK: 추후 통합후 삭제 예정 Color

let mainColor = Color(hex: "#090580")

struct MyMain: View {
    @StateObject private var studyViewModel = StudyViewModel()
    @State private var currentTab: Int = 0
    @State private var isMyProfile: Bool = false
    @State private var isFollowing: Bool = false
    
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var resumeViewModel = ResumeViewModel()
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
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
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
        }
        
        .onAppear(){
            userViewModel.fetchUser(userId: "BMTtH2JFcPNPiofzyzMI5TcJn1S2")
            resumeViewModel.fetchResume(userId: "0RPDyJNyzxSViwBvMw573KU0jKv1")
        }
        .refreshable {
            userViewModel.fetchUser(userId: "BMTtH2JFcPNPiofzyzMI5TcJn1S2")
            resumeViewModel.fetchResume(userId: "0RPDyJNyzxSViwBvMw573KU0jKv1")
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
        MyMain()
            
    }
}
