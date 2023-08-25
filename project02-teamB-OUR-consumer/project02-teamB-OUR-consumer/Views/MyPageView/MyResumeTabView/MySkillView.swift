//
//  MySkillView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MySkillCellView: View {
    @Binding var isMyProfile: Bool
    var skill: Skill
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(skill.skillName)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Spacer()
                
                if isMyProfile {
                    NavigationLink {
                        MySkillEditView(isShowingDeleteButton: true)
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
    var mySkills: [Skill]
    @Binding var isMyProfile: Bool

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("스킬")
                        .font(.system(size: 16))
                        .bold()
                    
                    Spacer()
                    
                    if isMyProfile {
                        NavigationLink {
                            MySkillEditView(isShowingDeleteButton: false)
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
            
            VStack {
                // 최대 3개 보이도록
                ForEach(0..<mySkills.count, id: \.self) { index in
                    if index < 3 {
                        MySkillCellView(isMyProfile: $isMyProfile, skill: mySkills[index])
                            .padding(.vertical, 8)
                        Divider()
                    }
                }
                .padding(.horizontal)
                
                // 스킬 3개 넘으면 더보기
                if mySkills.count > 3 {
                    NavigationLink {
                        MySkillMoreView(mySkills: mySkills, isMyProfile: $isMyProfile)
                    } label: {
                        Text("더보기")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                }
            }
        }
    }
}

struct MySkillView_Previews: PreviewProvider {
    static var previews: some View {
        MySkillView(mySkills: [], isMyProfile: .constant(true))
    }
}
