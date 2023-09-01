//
//  FeedPrivateSettingView.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/29.
//

import SwiftUI

struct FeedRecruitPrivateSettingView: View {
    @Binding var privacySetting : PrivacySetting
    
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

struct FeedPrivateSettingView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitPrivateSettingView(privacySetting: .constant(.Private))
    }
}
