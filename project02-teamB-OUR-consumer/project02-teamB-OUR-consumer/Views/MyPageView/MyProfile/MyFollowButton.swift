//
//  MyFollowButton.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct MyFollowButton: View {
    
    @Binding var isFollowing: Bool
    
    var body: some View {
        ZStack {
            
            if isFollowing {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("DefaultGray"))
                Text("팔로잉")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(mainColor)
                Text("팔로우")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
            // 팔로우 전 / 후 처리 필요
            
        }
    }
}

struct MyFollowButton_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowButton(isFollowing: .constant(false))
    }
}
