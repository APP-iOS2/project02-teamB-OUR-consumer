//
//  MyFollowingView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct MyFollowingView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    @State var followings: [User] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(followings) { following in
                        NavigationLink(destination: FollowingDetailView(following: following)) {
                            MyFollowingCell(userViewModel: userViewModel, following: following)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationBarTitle("Followings", displayMode: .inline)
            .onAppear {
                guard let userId = userViewModel.user?.id else { return print("옵셔널 못품 FOllowingView") }
                
                userViewModel.fetchFollowDetails(userId: userId, follow: .following) { users in
                    print("users \(users)")
                    self.followings = users
                }
            }
        }
    }
}

struct FollowingDetailView: View {
    var following: User

    var body: some View {
        Text("Detail for \(following.name)")
    }
}

struct MyFollowingView_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowingView(userViewModel: UserViewModel())
    }
}
