//
//  MyFollowersView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct MyFollowerView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
    @State var followers: [User] = []
    
    var body: some View {
        
        ScrollView {
            List(followers) { user in
                Text("\(user.name)")
            }
        }
        .onAppear {
            guard let userId = userViewModel.user?.id else { return print("옵셔널 못품") }
            
            userViewModel.fetchFollowDetails(userId: userId, follow: .follower) { users in
                print("user목록 \(users)")
                self.followers = users
            }
        }
    }
}

struct MyFollowerView_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowerView(userViewModel: UserViewModel())
    }
}

