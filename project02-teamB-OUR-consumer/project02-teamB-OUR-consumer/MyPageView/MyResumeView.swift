//
//  MyResumeView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyResumeView: View {
    @Binding var isMyProfile: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    MyIntroView(isMyProfile: $isMyProfile)
                        Rectangle()
                            .fill(Color("DefaultGray"))
                    MyWorkView(isMyProfile: $isMyProfile)
                        Rectangle()
                            .fill(Color("DefaultGray"))
                    MyProjectView(isMyProfile: $isMyProfile)
                        Rectangle()
                            .fill(Color("DefaultGray"))
                    MyEduView(isMyProfile: $isMyProfile)
                        Rectangle()
                            .fill(Color("DefaultGray"))
                    MySkillView(isMyProfile: $isMyProfile)
                }
            }
        }
    }
}

struct MyResumeView_Previews: PreviewProvider {
    static var previews: some View {
        MyResumeView(isMyProfile: .constant(true))
    }
}
