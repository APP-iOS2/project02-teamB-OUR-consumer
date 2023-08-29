//
//  MyWorkMoreView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/23.
//

import SwiftUI

struct MyWorkMoreView: View {
    var myWorks: [WorkExperience]
    @Binding var isMyProfile: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var resumeViewModel: ResumeViewModel
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<myWorks.count, id: \.self) { index in
                    VStack {
                        MyWorkCellView(isMyProfile: $isMyProfile, resumeViewModel: resumeViewModel, work: myWorks[index], index: index)
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
        .navigationTitle("경력")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isMyProfile {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
//                        MyWorkEditView(resumeViewModel: resumeViewModel, isShowingDeleteButton: false)
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
            MyWorkMoreView(myWorks: [], isMyProfile: .constant(true), resumeViewModel: ResumeViewModel())
        }
    }
}
