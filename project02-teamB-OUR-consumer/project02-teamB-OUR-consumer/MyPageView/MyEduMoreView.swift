//
//  MyEduMoreView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/23.
//

import SwiftUI

struct MyEduMoreView: View {
    @ObservedObject var resumeStore: ResumeStore = ResumeStore()
    @Binding var isMyProfile: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            // 전체 보이도록
            List {
                ForEach(0..<resumeStore.resume.education.count, id: \.self) { index in
                    VStack {
//                        MyEduCellView(isMyProfile: $isMyProfile, education: resumeStore.resume.education[index])
//                            .padding(.bottom, 8)
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
        .navigationTitle("교육")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isMyProfile {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
//                        MyWorkEditView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct MyEduMoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyEduMoreView(isMyProfile: .constant(true))
        }
    }
}
