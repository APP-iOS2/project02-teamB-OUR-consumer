//
//  MyEduMoreView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/23.
//

import SwiftUI

struct MyEduMoreView: View {
    var myEdu: [Education]
    @Binding var isMyProfile: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<myEdu.count, id: \.self) { index in
                    VStack {
                        MyEduCellView(isMyProfile: $isMyProfile, education: myEdu[index])
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
                        MyEduEditView(isShowingDeleteButton: false)
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
            MyEduMoreView(myEdu: [], isMyProfile: .constant(true))
        }
    }
}
