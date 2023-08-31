//
//  RecommendFriendView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/23.
//

import SwiftUI

struct RecommendFriendView: View {
    
    @ObservedObject private var idData: IdData = IdData()
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text("추천 친구")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 0))
                ForEach(idData.idStore) { recommend in
                    NavigationLink {
                        //
                    } label: {
                        RecommendDetailView(idStore: recommend)
                            .foregroundColor(.black)
                    }
                    
                    Button {
                        idData.followToggle(recommend)
                    } label: {
                        if !recommend.isFollow {
                            FollowButtonView()
                        } else {
                            FollowingButtonView()
                                .foregroundColor(Color(hex: 0x090580))
                        }
                    }
                    .padding(EdgeInsets(top: -20, leading: 50, bottom: 0, trailing: 0))
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 0))
                Divider()
            }
        }
    }
}

struct RecommendFriendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendFriendView()
    }
}
