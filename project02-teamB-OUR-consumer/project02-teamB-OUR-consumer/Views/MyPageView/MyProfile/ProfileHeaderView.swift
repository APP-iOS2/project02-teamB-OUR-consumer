//
//  ProfileHeaderView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    @Binding var isMyProfile: Bool
    @Binding var isFollowing: Bool
    
    var body: some View {
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
                        NavigationLink {
                            MyFollowView(currentTab: 0, userViewModel: userViewModel)
                        } label: {
                            HStack(spacing: 2) {
                                Text("팔로워")
                                Text("\(userViewModel.user?.numberOfFollower ?? 0)")
                                    .bold()
                            }
                        }
                        
                        NavigationLink {
                            MyFollowView(currentTab: 1, userViewModel: userViewModel)
                        } label: {
                            HStack(spacing: 2) {
                                Text("팔로잉")
                                Text("\(userViewModel.user?.numberOfFollowing ?? 0)")
                                    .bold()
                            }
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            HStack(spacing: 2) {
                                Text("게시물")
                                Text("2").bold()
                            }
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
                        isFollowing.toggle()
                    } label: {
                        MyFollowButton(isFollowing: $isFollowing)
                    }
                }
            }
            .frame(height: 36)
            
            
        }
        .padding(20)

    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(userViewModel: UserViewModel(), isMyProfile: .constant(true), isFollowing: .constant(false))
    }
}
