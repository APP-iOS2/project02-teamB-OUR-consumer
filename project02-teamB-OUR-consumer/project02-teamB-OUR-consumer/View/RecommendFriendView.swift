//
//  RecommendFriendView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/23.
//

import SwiftUI

struct RecommendFriendView: View {
    
    var idData: IdData
    @State private var isFollow: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                ForEach(idData.idStore) { friend in
                    NavigationLink {
                        //
                    } label: {
                        RecommendDetailView()
                            .foregroundColor(.black)
                    }
                    
                    Button {
                        isFollow.toggle()
                    } label: {
                        if !isFollow {
                            FollowButtonView()
                        } else {
                            FollowBtnView()
                                .foregroundColor(Color(hex: 0x090580))
                        }
                    }
                    .padding(.leading, 50)
                }
            }
        }
    }
}

struct RecommendFriendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendFriendView(idData: IdData())
    }
}
