//
//  MySkillView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MySkillCellView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    @Binding var isMyProfile: Bool
    var skill: Skill
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(skill.skillName)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Spacer()
                
                //MARK: 스킬 편집
                if isMyProfile {
                    NavigationLink {
                        MySkillEditView(resumeViewModel: resumeViewModel, isEditing: true, index: index)
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.black)
                    }
                }
            }
            
            Text(skill.description ?? "")
                .font(.system(size: 14))
        }
    }
}

struct MySkillView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    @Binding var isMyProfile: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("스킬")
                            .font(.system(size: 16))
                            .bold()
                        
                        Spacer()
                        
                        //MARK: 스킬 추가
                        if isMyProfile {
                            NavigationLink {
                                //MARK: 시간이 된다면...리팩토링^^
                                MySkillEditView(resumeViewModel: resumeViewModel, isEditing: false, index: 0)
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
                .padding(.top, 11)
                .padding(.horizontal)
                .foregroundColor(.black)
                
                VStack(alignment: .leading) {
                    if let resumeSkills = resumeViewModel.resume?.skills {
                        VStack {
                            // 스킬 최대 3개 보이도록
                            ForEach(0..<resumeSkills.count, id: \.self) { index in
                                if index < 3 {
                                    MySkillCellView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile, skill: resumeSkills[index], index: index)
                                        .padding(.vertical, 8)
                                    Divider()
                                }
                            }
                            .padding(.horizontal)
                            
                            // 스킬 3개 넘으면 더보기
                            if resumeSkills.count > 3 {
                                NavigationLink {
                                    MySkillMoreView(resumeViewModel: resumeViewModel, mySkills: resumeSkills, isMyProfile: $isMyProfile)
                                } label: {
                                    HStack {
                                        Text("더보기")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.vertical, 8)
                                
                                Divider()
                            }
                        }
                    } else {
                        // 스킬 없을 때
                        Text("스킬을 추가해주세요")
                            .font(.system(size: 14))
                            .padding(.leading, 16)
                    }
                }
            }
        }
    }
}


struct MySkillView_Previews: PreviewProvider {
    static var previews: some View {
        MySkillView(resumeViewModel: ResumeViewModel(), isMyProfile: .constant(true))
    }
}
