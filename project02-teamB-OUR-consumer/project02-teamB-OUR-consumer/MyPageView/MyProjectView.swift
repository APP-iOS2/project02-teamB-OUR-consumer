//
//  MyProjectView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyProjectCellView: View {
    var project: Project
    
    @Binding var isChangeItem: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("\(project.projectTitle) - \(project.jobTitle)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Spacer()
                
//                Button {
//                    // 프로젝트 편집
//                } label: {
//                    Image(systemName: "pencil")
//                        .foregroundColor(.black)
//                }
                NavigationLink(destination: MyProjectEditView(isChangeItem: $isChangeItem)) {
                        Image(systemName: "pencil")
                            .foregroundColor(.black)
                }
                .onTapGesture {
                    isChangeItem.toggle()
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
    @ObservedObject var resumeStore: ResumeStore = ResumeStore()
    
    @State var isDeleteItemAlert: Bool = false
    
    @State var isChangeItem: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("프로젝트")
                        .font(.system(size: 16))
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink {
                        MyProjectEditView(isChangeItem: $isChangeItem)
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                .padding(.vertical, 5)
            }
            .padding(.top, 11)
            .padding(.horizontal)
            .foregroundColor(.black)
            
            VStack {
                // 최대 3개 보이도록
                ForEach(0..<resumeStore.resume.projects.count, id: \.self) { index in
                    if index < 3 {
                        MyProjectCellView(project: resumeStore.resume.projects[index], isChangeItem: $isChangeItem)
                            .padding(.vertical, 8)
                        Divider()
                    }
                }
                .padding(.horizontal)
                
                // 프로젝트 3개 넘으면 더보기
                if resumeStore.resume.projects.count > 3 {
                    NavigationLink {
                        // 프로젝트 더보기
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

struct MyProjectView_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectView()
    }
}
