//
//  LeeSeungJun_Data.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import Foundation

class IdData: ObservableObject {
    @Published var idStore: [IdStore] = [
        IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.", isFollow: false),
        IdStore(id: UUID(), name: "정한두", profileImgString: "Jun", userID: "jeonghandoo", numberOfPosts: 2, numberOfFollowrs: 3, numberOfFollowing: 3203, numberOfComments: 79, profileMessage: "안녕하세요 정한두입니다.", isFollow: false),
        IdStore(id: UUID(), name: "김종찬", profileImgString: "Chan", userID: "kimjongchan", numberOfPosts: 212, numberOfFollowrs: 3389, numberOfFollowing: 212, numberOfComments: 3492, profileMessage: "안녕하세요 김종찬입니다.", isFollow: false),
        IdStore(id: UUID(), name: "김튜나", profileImgString: "Tuna", userID: "kimtuna", numberOfPosts: 21, numberOfFollowrs: 3, numberOfFollowing: 99, numberOfComments: 34, profileMessage: "참치는 맛있옹", isFollow: false)
    ]
    
    func followToggle(_ target: IdStore) {
        if let idIndex = idStore.firstIndex(where: { $0.id == target.id }) {
            idStore[idIndex].isFollow.toggle()
        }
    }
}
