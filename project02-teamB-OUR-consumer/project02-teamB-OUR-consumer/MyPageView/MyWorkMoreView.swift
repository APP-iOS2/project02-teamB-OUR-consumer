//
//  MyWorkMoreView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/23.
//

import SwiftUI

struct MyWorkMoreView: View {
    @ObservedObject var resumeStore: ResumeStore = ResumeStore()
    @Binding var isMyProfile: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var isChangeItem: Bool

    
    var body: some View {
        NavigationStack {
            // 전체 보이도록
            List {
                ForEach(0..<resumeStore.resume.workExperience.count, id: \.self) { index in
                    VStack {
                        MyWorkCellView(isMyProfile: $isMyProfile, work: resumeStore.resume.workExperience[index], isChangeItem: $isChangeItem)
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
        .navigationTitle("경력")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isMyProfile {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MyWorkEditView(isChangeItem: $isChangeItem)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct MyWorkMoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyWorkMoreView(isMyProfile: .constant(true), isChangeItem: .constant(true))
        }
    }
}
