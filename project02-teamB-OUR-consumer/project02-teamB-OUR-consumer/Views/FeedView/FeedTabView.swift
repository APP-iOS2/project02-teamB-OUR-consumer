//
//  FeedTabView.swift
//  HomeTab
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedTabView: View {
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TitleView()
                        .padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
                    Divider()
                    FeedView()
//                    RecommendFriendView()
                }
                
                // 알림 권한 요청때문에 추가했습니다
                .onAppear{
                    UNNotificationService.shared.requestAuthNoti()
                }
            }
            .navigationTitle("")
        }
        .refreshable {
            postViewModel.fetchPostForCurrentUserFollower(limit: 3)
        }
    }
}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
            .environmentObject(PostViewModel())
    }
}
