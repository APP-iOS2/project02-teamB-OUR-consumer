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
    @State private var isMyProfile: Bool = false
    //MARK: 팔로우 하고 있으면 팔로잉 (팔로잉 누르면 취소 - alert)
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                HStack {
                    Text("내 프로필")
                        .font(.system(size: 20))
                        .bold()
                    Spacer()
                    if isMyProfile == true {
                        Text("북마크")
                        Text("톱니")
                    }
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 20) {
                            Image("OUR_Logo")
                                .resizable()
                                .frame(width: 86, height: 86)
                                .cornerRadius(43)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("김멋사")
                                    .bold()
                                    .font(.system(size: 24))
                                HStack {
                                    Text("팔로워") + Text(" 22").bold()
                                    Text("팔로잉") + Text(" 32").bold()
                                    Text("게시물") + Text(" 64").bold()
                                }
                            }
                            
                        }
                        
                        Text("간단 자기소개")
                            .padding(.vertical)
                        
                        HStack(spacing: 12) {
                            if isMyProfile == true {
                                NavigationLink {
                                    // TODO: 편집 페이지로 이동
                                    MyMainProfileEditView(username: "회사")
                                } label: {
                                    Text("프로필 편집")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    // TODO: 공유 페이지로 이동
                                    
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.black, lineWidth: 1)
                                        Text("프로필 공유")
                                    }
//                                    Text("프로필 공유")
//                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 5)
//                                                .stroke(Color.black, lineWidth: 1)
//                                        )
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
                            MyResumeView(isMyProfile: $isMyProfile)
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
