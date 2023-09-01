//
//  StudyReplyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI

struct StudyReplyView: View {
    
    @StateObject var viewModel: StudyViewModel
    
    @State var editComment: String = ""
    @Binding var showAlert: Bool
    @State var content: String = ""
    //현재 로그인 된 아이디
    @State var commentUserId: String = "test"
    
    @State var isShowingCommentReportSheet = false
    
    var body: some View {
        VStack{
            
            HStack() {
                Spacer()
                
                Text("댓글 \(viewModel.studyDetail.comments.count)")
                    .font(.system(size: 14))
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.trailing, 20)
            
            Divider()
            
            //List {
            ForEach(viewModel.studyDetail.comments) { comment in
                StudyReplyDetailView(studyViewModel: viewModel, comment: comment, index: 0, showAlert: $showAlert, isShowingCommentReportSheet: $isShowingCommentReportSheet)
            }
            // }
            .listStyle(.plain)
            .refreshable {
                //새로고침
            }
            .padding([.horizontal, .bottom], 10)
            .padding([.leading,.trailing], 8)
            .sheet(isPresented: $isShowingCommentReportSheet) {
                StudyReportView(viewModel: viewModel, isStudy: false)
            }
            
        }
        
    }
}

struct StudyReplyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyReplyView(viewModel: StudyViewModel(), showAlert: .constant(false))
    }
}
