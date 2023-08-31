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
                    Divider()
//                    RecommendFriendView()
                }
            }
        }
    }
}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
            .environmentObject(PostViewModel())
    }
}
