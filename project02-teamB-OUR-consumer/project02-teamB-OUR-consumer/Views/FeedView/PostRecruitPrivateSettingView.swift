//
//  PostRecruitPrivateSettingView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/31.
//

import SwiftUI

struct PostRecruitPrivateSettingView: View {
    @Binding var privacySetting: Bool
    
    var body: some View {
        HStack{
            Picker("PrivacySetting", selection: $privacySetting) {
                Text("Public").tag(PrivacySetting.Public)
                Text("Private").tag(PrivacySetting.Private)
            }
            .pickerStyle(.menu)
            Spacer()
        }
    }
}

struct PostRecruitPrivateSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PostRecruitPrivateSettingView(privacySetting: .constant(false))
    }
}
