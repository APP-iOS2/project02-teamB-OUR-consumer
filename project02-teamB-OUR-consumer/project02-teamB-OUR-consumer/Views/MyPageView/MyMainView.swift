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
    @State private var isMyProfile: Bool = true
    
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var resumeViewModel = ResumeViewModel()
    //MARK: 팔로우 하고 있으면 팔로잉 (팔로잉 누르면 취소 - alert)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // 설정 및 북마크 아이콘
                    ProfileBar(isMyProfile: $isMyProfile)
                        .padding(.horizontal)
                    
                    // 프로필 헤더
//                    ProfileHeaderView(isMyProfile: $isMyProfile, userViewModel: userViewModel)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 20) {
                            Image(userViewModel.user?.profileImage ?? "OUR_Logo")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(50)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(userViewModel.user?.name ?? "")
                                    .bold()
                                    .font(.system(size: 16))
                                HStack(spacing: 20) {
                                    HStack(spacing: 2) {
                                        Text("팔로워")
                                        Text("\(userViewModel.user?.numberOfFollower ?? 0)").bold()
                                    }
                                    
                                    HStack(spacing: 2) {
                                        Text("팔로잉")
                                        Text("\(userViewModel.user?.numberOfFollowing ?? 0)").bold()
                                    }
                                    
                                    HStack(spacing: 2) {
                                        Text("게시물")
                                        Text("2").bold()
                                    }
                                }
                                .font(.system(size: 12))
                            }
                        }
                        Text("\(userViewModel.user?.profileMessage ?? "자기소개")")
                            .font(.system(size: 14))
                            .padding(.vertical)
                        
                        HStack(spacing: 12) {
                            if isMyProfile == true {
                                NavigationLink {
                                    // TODO: 편집 페이지로 이동
                                    MyMainProfileEditView(userViewModel: userViewModel)
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.black, lineWidth: 1)
                                        Text("프로필 편집")
                                            .font(.system(size: 14))
                                    }
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    // TODO: 공유 페이지로 이동
                                    
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.black, lineWidth: 1)
                                        Text("프로필 공유")
                                            .font(.system(size: 14))
                                    }
                                }
                                .buttonStyle(.plain)
                            } else {
                                // 팔로우 버튼
                                Button {
                                    // TODO: 팔로우 액션
                                    
                                } label: {
                                    ZStack {
                                        
                                        // 팔로우 전 / 후 처리 필요
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(mainColor)
                                        
                                        Text("팔로우")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                        
                                    }
                                }
                            }
                        }
                        .frame(height: 36)
                        
                        
                    }
                    .padding(20)
         
                    // 탭바들 자리 (index 값 따라서 다른뷰 보여주면 될 듯)
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        Section {
                            switch currentTab {
                            case 0:
                                MyResumeView(myResume: resumeViewModel.resume, isMyProfile: $isMyProfile)
                            case 1:
                                MyBoardView()
                            case 2:
                                MyStudyView(studyArray: studyViewModel.studyArray)
                            default:
                                EmptyView()
                            }
                        } header: {
                            MyMainTabBar(currentTab: $currentTab, namespace: Namespace())
                        }
                        
                    }
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
}

struct MyMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyMain()
            
    }
}
