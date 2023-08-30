//
//  MyEduMoreView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/23.
//

import SwiftUI

struct MyEduMoreView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    var myEdu: [Education]
    @Binding var isMyProfile: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<myEdu.count, id: \.self) { index in
                    VStack {
                        MyEduCellView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile, education: myEdu[index], index: index)
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
        .navigationTitle("교육")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isMyProfile {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MyEduEditView(resumeViewModel: resumeViewModel, isEditing: isMyProfile, index: 0)
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
            MyEduMoreView(resumeViewModel: ResumeViewModel(), myEdu: [], isMyProfile: .constant(true))
        }
    }
}
