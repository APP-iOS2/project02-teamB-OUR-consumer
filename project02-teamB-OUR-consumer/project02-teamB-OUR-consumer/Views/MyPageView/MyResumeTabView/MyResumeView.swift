//
//  MyResumeView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyResumeView: View {
    var myResume: Resume?
    @Binding var isMyProfile: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let myResume = myResume {
                    VStack(spacing: 0) {
                        MyIntroView(myIntro: myResume.introduction, isMyProfile: $isMyProfile)
                            Rectangle()
                                .fill(Color("DefaultGray"))
                        MyWorkView(myWorks: myResume.workExperience, isMyProfile: $isMyProfile)
                            Rectangle()
                                .fill(Color("DefaultGray"))
                        MyProjectView(myProjects: myResume.projects, isMyProfile: $isMyProfile)
                            Rectangle()
                                .fill(Color("DefaultGray"))
                        MyEduView(myEdu: myResume.education, isMyProfile: $isMyProfile)
                            Rectangle()
                                .fill(Color("DefaultGray"))
                        MySkillView(mySkills: myResume.skills, isMyProfile: $isMyProfile)
                    }
                } else {
                    Text("이력서를 찾을 수 없습니다")
                }
            }
        }
    }
}

struct MyResumeView_Previews: PreviewProvider {
    static var previews: some View {
        MyResumeView(myResume: nil, isMyProfile: .constant(true))
    }
}
