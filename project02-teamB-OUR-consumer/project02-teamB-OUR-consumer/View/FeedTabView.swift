//
//  FeedTabView.swift
//  HomeTab
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedTabView: View {
    
    @StateObject private var idData: IdData = IdData()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TitleView()
                    FeedView()
                    RecommendFriendView(idStore: IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.", isFollow: false), idData: idData)
                }
            }
        }
    }
}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
    }
}
