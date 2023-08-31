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
                StudyReplyDetailView(studyViewModel: viewModel, comment: comment, index: 0, showAlert: $showAlert)
            }
            // }
            .listStyle(.plain)
            .refreshable {
                //새로고침
            }
            .padding([.horizontal, .bottom], 10)
            .padding([.leading,.trailing], 8)
            
            
            HStack {
                //프로필 이미지
                Image("OUR_Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .clipShape(Circle())
                TextField("댓글을 입력하세요", text: $content, axis: .vertical)
                Button("등록") {
                    Task {
                        await viewModel.addComments(content: content)
                        content = ""
                    }
                }
            }
            .padding()
            
        }
        .onAppear {
        }
        
    }
}

struct StudyReplyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyReplyView(viewModel: StudyViewModel(), showAlert: .constant(false))
    }
}
