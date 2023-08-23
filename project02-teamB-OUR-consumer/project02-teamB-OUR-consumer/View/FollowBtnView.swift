//
//  FollowBtnView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FollowBtnView: View {
    var frameWidth: Double = 100
    var frameHeight: Double = 35
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: frameWidth, height: frameHeight)
                .background(Color(hex: 0x090580))
                .cornerRadius(5)
                
            Text("팔로잉")
                .foregroundColor(Color(hex: 0x090580))
                .font(.title2)
                .bold()
                .frame(width: frameWidth - 3, height: frameHeight - 3)
                .background(Color.white)
                .cornerRadius(3)

        }
    }
}

struct FollowBtnView_Previews: PreviewProvider {
    static var previews: some View {
        FollowBtnView()
    }
}
