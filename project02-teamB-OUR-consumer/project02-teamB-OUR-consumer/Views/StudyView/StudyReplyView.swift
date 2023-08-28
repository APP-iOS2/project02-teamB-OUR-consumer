//
//  StudyReplyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI

struct StudyReplyView: View {
    
    var studyViewModel: StudyViewModel
    var study: Study
    @State var studyDetail: StudyDetail = StudyDetail.defaultStudyDetail
    
    
    @State var editComment: String = ""
    @State var isEditing: Bool = false
    
    @State var content: String = ""
    //현재 로그인 된 아이디
    @State var commentUserId: String = "성은"
    
    var body: some View {
        VStack{
        
            HStack() {
                Spacer()
                
                Text("댓글 \(studyDetail.comments.count)")
                    .font(.system(size: 14))
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.trailing, 20)
            
            Divider()
            
            //List {
            ForEach(studyDetail.comments) { comment in
                StudyReplyDetailView(studyViewModel: studyViewModel, comment: comment, index: 0, isEditing: $isEditing)
            }
            // }
            .listStyle(.plain)
            .refreshable {
                //새로고침
            }
            .padding([.horizontal, .bottom], 10)
            .padding([.leading,.trailing], 8)
            
            
//            HStack {
//                //프로필 이미지
//                Image("OUR_Logo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 40)
//                    .clipShape(Circle())
//                //댓글입력창
//                if isEditing {
//
//                    TextField("Edit reply",text: $content)
//                    //                        .onTapGesture {
//                    //                            studyGroupComments[2].content = ""
//                    //                        }
//                    Button("Edit") {
//
//                        isEditing = false
//                    }
//                } else {
//                    TextField("댓글을 입력하세요", text: $content, axis: .vertical)
//                    Button("등록") {
//                        let comment = StudyComment(userId: commentUserId, content: content)
//                        studyCommentStore.comments.append(comment)
//                        print("\(studyCommentStore.comments)")
//                        content = ""
//                    }
//                }
//            }
//            .padding()
            
        }
        .onAppear {
            studyViewModel.makeStudyDetail(study: study) { studyDetail in
                self.studyDetail = studyDetail
                print(self.studyDetail)
            }
        }
        
    }
}

struct StudyReplyView_Previews: PreviewProvider {
    @State var studyReplies: [String] = ["1빠", "2빠"]
    static var previews: some View {
        StudyReplyView(studyViewModel: StudyViewModel(), study: Study(creatorId: "", title: "", description: "", studyDate: "", deadline: "", isOnline: false, currentMemberIds: [""], totalMemberCount: 0, createdAt: "23.08.28"))

    }
}
