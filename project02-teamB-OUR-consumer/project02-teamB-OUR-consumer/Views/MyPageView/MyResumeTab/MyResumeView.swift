//
//  MyResumeView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyResumeView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    @Binding var isMyProfile: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    MyIntroView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile)
                    Rectangle()
                        .fill(Color("DefaultGray"))
                    MyWorkView(isMyProfile: $isMyProfile, resumeViewModel: resumeViewModel)
                    Rectangle()
                        .fill(Color("DefaultGray"))
                    MyProjectView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile)
                    Rectangle()
                        .fill(Color("DefaultGray"))
                    MyEduView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile)
                    Rectangle()
                        .fill(Color("DefaultGray"))
                    MySkillView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile)
                }
            }
        }
    }
}

struct MyResumeView_Previews: PreviewProvider {
    static var previews: some View {
        MyResumeView(resumeViewModel: ResumeViewModel(), isMyProfile: .constant(true))
    }
}
