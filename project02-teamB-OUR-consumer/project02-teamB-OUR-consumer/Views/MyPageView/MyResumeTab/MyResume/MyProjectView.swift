//
//  MyProjectView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyProjectCellView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    @Binding var isMyProfile: Bool
    var project: Project
    var index: Int
        
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("\(project.projectTitle) - \(project.jobTitle)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Spacer()
                
                if isMyProfile {
                    NavigationLink {
                        MyProjectEditView(resumeViewModel: resumeViewModel, isEditing: true, index: index)
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.black)
                    }
                }

            }
            
            Text("2023.08 - 현재")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            Text(project.description ?? "")
                .font(.system(size: 14))
        }
    }
}

struct MyProjectView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    var myProjects: [Project] {
        resumeViewModel.resume?.projects ?? []
    }
    @Binding var isMyProfile: Bool
    
    @State var isDeleteItemAlert: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("프로젝트")
                            .font(.system(size: 16))
                            .bold()
                        
                        Spacer()
                        
                        if isMyProfile {
                            NavigationLink {
                                MyProjectEditView(resumeViewModel: resumeViewModel, isEditing: false, index: 0)
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
                    VStack {
                        // 최대 3개 보이도록
                        ForEach(0..<myProjects.count, id: \.self) { index in
                            if index < 3 {
                                MyProjectCellView(resumeViewModel:resumeViewModel, isMyProfile: $isMyProfile, project: myProjects[index], index: index)
                                    .padding(.vertical, 8)
                                Divider()
                            }
                        }
                        .padding(.horizontal)
                        
                        // 프로젝트 3개 넘으면 더보기
                        if myProjects.count > 3 {
                            NavigationLink {
                                MyProjectMoreView(resumeViewModel: resumeViewModel, myProjects: myProjects, isMyProfile: $isMyProfile)
                            } label: {
                                Text("더보기")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, 8)
                            
                            Divider()
                        }
                        
                        // 프로젝트 없을 때
                        if myProjects.count == 0 {
                            Text("프로젝트를 추가해주세요")
                                .font(.system(size: 14))
                                .padding([.leading, .bottom])
                        }
                    }
                }
            }
        }
    }
}

struct MyProjectView_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectView(resumeViewModel: ResumeViewModel(), isMyProfile: .constant(true))
    }
}
