//
//  ProfileHeaderView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이희찬 on 2023/08/26.
//

import SwiftUI

struct ProfileHeaderView: View {
    @Binding var isMyProfile: Bool
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Image("OUR_Logo") //user.profileImage로 교체해야 함
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(userViewModel.user?.name ?? "")
                        .font(.system(size: 20))
                        .bold()
                    Text(userViewModel.user?.email ?? "")
                }
            }
            Text(userViewModel.user?.profileMessage ?? "")
                .lineLimit(2)
            
            if isMyProfile {
                HStack(spacing: 10) {
                        NavigationLink(destination: ProfileEditView(userViewModel: userViewModel)){
                            Text("프로필 편집")
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Button("프로필 공유") {
                        // 프로필 공유 동작 구현
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.top, 10)
            }
        }
        .padding()
    }
}



struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(isMyProfile: .constant(true), userViewModel: UserViewModel())
    }
}
