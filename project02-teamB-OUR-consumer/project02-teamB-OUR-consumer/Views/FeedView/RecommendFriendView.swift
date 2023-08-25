//
//  RecommendFriendView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/23.
//

import SwiftUI

struct RecommendFriendView: View {
    
    var idStore: IdStore
    var idData: IdData
    @State var isFollow1: Bool = false
    @State var isFollow2: Bool = false
    @State var isFollow3: Bool = false
    @State var isFollow4: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("추천 친구")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                
                Group {
                    NavigationLink {
                        //
                    } label: {
                        RecommendDetailView(idStore: IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.", isFollow: false))
                            .foregroundColor(.black)
                    }
                    
                    Button {
                        isFollow1.toggle()
                    } label: {
                        if !isFollow1 {
                            FollowButtonView()
                        } else {
                            FollowingButtonView()
                                .foregroundColor(Color(hex: 0x090580))
                        }
                    }
                    .padding(.leading, 50)
                }
                
                Group {
                    NavigationLink {
                        //
                    } label: {
                        RecommendDetailView(idStore: IdStore(id: UUID(), name: "정한두", profileImgString: "Doo", userID: "jeonghandoo", numberOfPosts: 2, numberOfFollowrs: 3, numberOfFollowing: 3203, numberOfComments: 79, profileMessage: "안녕하세요 정한두입니다.", isFollow: false))
                            .foregroundColor(.black)
                    }
                    
                    Button {
                        isFollow2.toggle()
                    } label: {
                        if !isFollow2 {
                            FollowButtonView()
                        } else {
                            FollowingButtonView()
                                .foregroundColor(Color(hex: 0x090580))
                        }
                    }
                    .padding(.leading, 50)
                }
            }
            .padding()
        }
    }
}

struct RecommendFriendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendFriendView(idStore: IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.", isFollow: false), idData: IdData())
    }
}
