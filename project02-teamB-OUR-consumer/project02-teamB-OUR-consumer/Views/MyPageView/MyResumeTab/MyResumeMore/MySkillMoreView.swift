//
//  MySkillMoreView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/23.
//

import SwiftUI

struct MySkillMoreView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    var mySkills: [Skill]
    @Binding var isMyProfile: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<mySkills.count, id: \.self) { index in
                    VStack {
                        MySkillCellView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile, skill: mySkills[index], index: index)
                            .padding(.vertical, 8)
                        Divider()
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 8)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.backward")
            })
        }
        .navigationTitle("스킬")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isMyProfile {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MySkillEditView(resumeViewModel: resumeViewModel, isEditing: false, index: 0)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct MySkillMoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MySkillMoreView(resumeViewModel: ResumeViewModel(), mySkills: [], isMyProfile: .constant(true))
        }
    }
}
