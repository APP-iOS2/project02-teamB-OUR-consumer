//
//  MyFollowerCell.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct MyFollowerCell: View {
    @ObservedObject var userViewModel: UserViewModel
    var follower: User
    
    var body: some View {
        HStack(spacing: 8) {
            Image("OUR_Logo")
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(50)
            
            Text(follower.name)
                .padding(.leading, 4)
            
            Spacer()
            
            if let followings = userViewModel.user?.following {
                if followings.contains(where: { $0 == follower.id }) {
                    Button(action:{
                        userViewModel.unfollowUser(targetUserId: follower.id ?? "")
                    }) {
                        Text("unfollow")
                    }
                } else {
                    Button(action: {
                        userViewModel.followUser(targetUserId: follower.id ?? "")
                    }){
                        Text("follow")
                    }
                }
            }
            
        }
    }
}

struct MyFollowerCell_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowerCell(userViewModel:UserViewModel() ,follower: User(name: "chan", email: "chan000@email.com"))
    }
}
