//
//  StudyCommentReportView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/23.
//

import SwiftUI

struct StudyCommentReportView: View {
    
    var userId: String
    var comment: StudyGroupComment
    
    var body: some View {
        VStack {
            Text("신고")
                .fontWeight(.bold)
            Divider()
            VStack(alignment: .leading) {
                Text("신고하는 댓글")
                    .fontWeight(.heavy)
                StudyReplyDetailView(userId: "성은", comment: comment)
            }
            HStack {
                Spacer()
                Button("취소") {
                    //취소엔...뭐하됴
                }
                Spacer()
                Button("신고하기") {
                    //신고하는 액션
                }
                Spacer()
                
            }
            .padding()
            
            Divider()
            
            
        }
        .padding()
    }
}

struct StudyCommentReportView_Previews: PreviewProvider {
    static var previews: some View {
        StudyCommentReportView(userId: "성은", comment: StudyGroupComment(userId: "성은", content: "최악의 스터디 소개글이네여 ;;"))
    }
}
