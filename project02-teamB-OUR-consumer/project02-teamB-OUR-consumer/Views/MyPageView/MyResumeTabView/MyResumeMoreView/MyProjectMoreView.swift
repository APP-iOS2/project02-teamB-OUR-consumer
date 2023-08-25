//
//  MyProjectMoreView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/23.
//

import SwiftUI

struct MyProjectMoreView: View {
    var myProjects: [Project]
    @Binding var isMyProfile: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<myProjects.count, id: \.self) { index in
                    VStack {
                        MyProjectCellView(isMyProfile: $isMyProfile, project: myProjects[index])
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
            MyProjectMoreView(myProjects: [], isMyProfile: .constant(true))
        }
    }
}
