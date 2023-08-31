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
                        .padding(.top, -100)
                    Divider()
                    FeedView()
                    Divider()
//                    RecommendFriendView()
                }
                
                // 알림 권한 요청때문에 추가했습니다
                .onAppear{
                    UNNotificationService.shared.requestAuthNoti()
                }
            }
            .navigationTitle("")
        }
    }
}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
    }
}
