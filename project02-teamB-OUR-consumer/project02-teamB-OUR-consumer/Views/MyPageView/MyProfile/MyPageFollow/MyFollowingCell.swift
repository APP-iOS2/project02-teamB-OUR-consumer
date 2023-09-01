//
//  MyFollowingCell.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct MyFollowingCell: View {
    @ObservedObject var userViewModel: UserViewModel
    var following: User
    @State var showingAlert: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            Image("OUR_Logo")
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(50)
            
            Text(following.name)
                .padding(.leading, 4)
            
            Spacer()
            if let followings = userViewModel.user?.following {
                if followings.contains(where: { $0 == following.id }) {
                    
                    Button(action:{
                        showingAlert = true
//                        userViewModel.unfollowUser(targetUserId: follower.id ?? "")
                    }) {
                        Text("팔로잉")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(AColor.main.color)
                            .frame(width: 90.05, height: 27.85)
                            .background(Color.white)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(AColor.main.color, lineWidth: 2)
                            )
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("⚠️알림"), message: Text("정말 팔로우를 취소하시겠습니까?"), primaryButton: .destructive(Text("팔로우 취소"), action: {
                            userViewModel.unfollowUser(targetUserId: following.id ?? "")
                            print("진행.")
                        }), secondaryButton: .cancel(Text("취소")))
                    }
                } else {
                    Button(action: {
                        //TODO: alarm으로 notification
                        userViewModel.followUser(targetUserId: following.id ?? ""){ _,_ in
                            
                        }
                        print("팔로우 되었습니다.")
                    }){
                        Text("팔로우")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 90.05, height: 27.85)
                            .background(AColor.main.color)
                            .cornerRadius(5)
                    }
                }
            }
//            if let followings = userViewModel.user?.following {
//                if followings.contains(where: { $0 == following.id }) {
//                    Button(action:{
//                        userViewModel.unfollowUser(targetUserId: following.id ?? "")
//                    }) {
//                        Text("unfollow")
//                    }
//                } else {
//                    Button(action: {
//                        userViewModel.followUser(targetUserId: following.id ?? "")
//                    }){
//                        Text("follow")
//                    }
//                }
//            }
            
        }
    }
}

struct MyFollowingCell_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowingCell(userViewModel:UserViewModel(), following: User(name: "chan", email: "chan000@email.com"))
    }
}
