//
//  MyMainView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/22.
//

import SwiftUI

// MARK: 추후 통합후 삭제 예정 Color

let mainColor = Color(hex: "#090580")

struct MyMain: View {
    
    @State private var currentTab: Int = 0
    @State private var isMyProfile: Bool = true
    //MARK: 팔로우 하고 있으면 팔로잉 (팔로잉 누르면 취소 - alert)
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                HStack {
                    if isMyProfile {
                        Text("내 프로필")
                            .font(.system(size: 16))
                            .bold()
                    } else {
                        Text("프로필")
                            .font(.system(size: 16))
                            .bold()
                    }
                    Spacer()
                    if isMyProfile == true {
                        NavigationLink {
                            MyBookMarkView()
                        } label: {
                            Image(systemName: "bookmark")
                                .foregroundColor(.black)
                        }
                        NavigationLink {
                            SettingView()
                        } label: {
                            Image(systemName: "gearshape")
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 20) {
                            Image("OUR_Logo")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(50)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("김멋사")
                                    .bold()
                                    .font(.system(size: 16))
                                HStack(spacing: 20) {
                                    HStack(spacing: 2) {
                                        Text("팔로워")
                                        Text("233").bold()
                                    }
                                    
                                    HStack(spacing: 2) {
                                        Text("팔로잉")
                                        Text("214").bold()
                                    }
                                    
                                    HStack(spacing: 2) {
                                        Text("게시물")
                                        Text("2").bold()
                                    }
                                    
                                }
                                .font(.system(size: 12))
                                
                            }
                            
                        }
                        Text("간단 자기소개")
                            .font(.system(size: 14))
                            .padding(.vertical)
                        
                        HStack(spacing: 12) {
                            if isMyProfile == true {
                                NavigationLink {
                                    // TODO: 편집 페이지로 이동
                                    MyMainProfileEditView(username: "회사")
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
                                MyResumeView(isMyProfile: $isMyProfile)
                            case 1:
                                MyBoardView()
                            case 2:
                                MyStudyView()
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
        
    }
}

struct MyMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyMain()
    }
}
