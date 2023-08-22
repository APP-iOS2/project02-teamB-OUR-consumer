//
//  FeedTabView.swift
//  HomeTab
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedTabView: View {
    var body: some View {
        VStack {
            TitleView()
            SheetView(idStore: IdStore(id: UUID(), name: "이승준", imgString: "Jun", accountID: "leeseungjun", numberOfPosts: 200, numberOfFollowrs: 50000, numberOfFollowing: 4, briefIntro: "안녕하세요 이승준입니다."))
        }
        .padding()
    }
}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
    }
}
