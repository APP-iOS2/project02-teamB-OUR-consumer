//
//  MyFollowingView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct MyFollowingView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    @State var followers: [User] = []
    
    var body: some View {
        
        ScrollView {
            List(followers) { user in
                Text("\(user.name)")
            }
        }
        .onAppear {
            guard let userId = userViewModel.user?.id else { return print("옵셔널 못품 FOllowingView") }
            
            userViewModel.fetchFollowDetails(userId: userId, follow: .follower) { users in
                print("users \(users)")
                self.followers = users
            }
        }
    }
}

struct MyFollowingView_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowingView(userViewModel: UserViewModel())
    }
}
