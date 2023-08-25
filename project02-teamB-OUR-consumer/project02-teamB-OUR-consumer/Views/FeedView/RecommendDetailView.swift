//
//  RecommendDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/23.
//

import SwiftUI

struct RecommendDetailView: View {
    
    var idStore: IdStore
    
    var body: some View {
        HStack {
            Image("\(idStore.profileImgString)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 40)
            VStack(alignment: .leading) {
                Text("\(idStore.name)")
                    .font(.system(size: 16))
                    .fontWeight(.heavy)
                Text("\(idStore.profileMessage)")
                    .font(.system(size: 14))
                    .fontWeight(.light)
            }
            Spacer()
        }
    }
}

struct RecommendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendDetailView(idStore: IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.", isFollow: false))
    }
}
