//
//  FollowButtonView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/23.
//

import SwiftUI

struct FollowButtonView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 100, height: 35)
                .background(Color.white)
                .cornerRadius(5)
            
            Text("팔로우")
                .foregroundColor(.white)
                .font(.system(size: 14))
                .fontWeight(.bold)
                .frame(width: 100, height: 35)
                .background(Color(hex: 0x090580))
                .cornerRadius(5)
            
            
        }
    }
}

struct FollowButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FollowButtonView()
    }
}
