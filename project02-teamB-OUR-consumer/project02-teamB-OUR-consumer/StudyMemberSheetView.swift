//
//  StudyMemberSheetView.swift
//  project02-teamB-OUR-consumer
//
//  Created by yuri rho on 2023/08/23.
//

import SwiftUI

struct StudyMemberSheetView: View {
    @Binding var isShowingStudyMemberSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("스터디에 참여한 멤버 목록을 나타냅니다.")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingStudyMemberSheet = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct StudyMemberSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StudyMemberSheetView(isShowingStudyMemberSheet: .constant(true))
    }
}
