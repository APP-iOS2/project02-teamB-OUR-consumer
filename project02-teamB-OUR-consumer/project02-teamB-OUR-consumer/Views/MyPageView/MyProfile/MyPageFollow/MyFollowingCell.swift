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
                        userViewModel.unfollowUser(targetUserId: following.id ?? "")
                    }) {
                        Text("unfollow")
                    }
                } else {
                    Button(action: {
                        userViewModel.followUser(targetUserId: following.id ?? "")
                    }){
                        Text("follow")
                    }
                }
            }
            
        }
    }
}

struct MyFollowingCell_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowingCell(userViewModel:UserViewModel(), following: User(name: "chan", email: "chan000@email.com"))
    }
}
