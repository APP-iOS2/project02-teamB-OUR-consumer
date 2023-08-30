//
//  ProfileBar.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이희찬 on 2023/08/26.
//

import SwiftUI

struct ProfileBar: View {
    @Binding var isMyProfile: Bool
    
    var body: some View {
        HStack {
            if isMyProfile {
                Text("내 프로필")
                    .font(.system(size: 20))
                    .bold()
            } else {
                Text("프로필")
                    .bold()
            }
            Spacer()
            if isMyProfile {
                NavigationLink {
                    MyBookMarkView()
                } label: {
                    Image(systemName: "bookmark")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                NavigationLink {
                    SettingView()
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
            }
        }
    }
}


struct ProfileBar_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBar(isMyProfile: .constant(true))
    }
}

