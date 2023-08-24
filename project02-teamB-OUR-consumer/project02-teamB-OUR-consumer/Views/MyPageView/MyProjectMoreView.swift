//
//  MyProjectMoreView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/23.
//

import SwiftUI

struct MyProjectMoreView: View {
    @ObservedObject var resumeStore: ResumeStore = ResumeStore()
    @Binding var isMyProfile: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            // 전체 보이도록
            List {
                ForEach(0..<resumeStore.resume.projects.count, id: \.self) { index in
                    VStack {
                        MyProjectCellView(isMyProfile: $isMyProfile, project: resumeStore.resume.projects[index])
                            .padding(.bottom, 8)
                        Divider()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.backward")
            })
        }
        .navigationTitle("프로젝트")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isMyProfile {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MyWorkEditView(isShowingDeleteButton: true)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct MyProjectMoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyProjectMoreView(isMyProfile: .constant(true))
        }
    }
}
