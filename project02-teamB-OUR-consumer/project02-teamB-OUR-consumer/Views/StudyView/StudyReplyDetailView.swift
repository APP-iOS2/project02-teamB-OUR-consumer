//
//  StudyReplyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI

struct StudyReplyDetailView: View {
    
    
    @State private var showAlert: Bool = false
    @Binding var isEditing: Bool
    
    var userId: String
    var comment: StudyGroupComment
    
    var body: some View {
        LazyVStack {
            HStack {
                Button {
                    //해당 프로필 시트 올려주는 ~
                } label: {
                    comment.profileImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                        .clipShape(Circle())
                }

                
                VStack(alignment: .leading, spacing: 5){
                    HStack {
                        Text(comment.userId)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        Text(comment.createdDate)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
//                        Button {
//                            //대댓글
//                        } label: {
//                            Text("Reply")
//                                .font(.system(size: 12))
//                                .foregroundColor(.gray)
//                        }

                    }
                    Text(comment.content)
                        .font(.system(size: 14))
                    
                }
                Spacer()
                
                Menu {
                    if comment.userId == userId {
                        Button {
                            isEditing = true
                        } label: {
                            Text("수정하기")
                        }
                        // 삭제 : 포스트 아이디가 같은경우도 !!해보기 
                        Button {
                            showAlert = true
                            //삭제하는 func 만들어서 호출은 alert에서
                        } label: {
                            Text("삭제하기")
                        }
                    } else {
                        NavigationLink {
                            StudyCommentReportView(userId: userId, comment: comment, isEditing: $isEditing)
                        } label: {
                            Text("신고하기")
                                .foregroundColor(.red)
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .padding()
                }
                .foregroundColor(.gray)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("정말 삭제하겠습니까?"),
                      message: Text("댓글을 삭제합니다"),
                      primaryButton: .destructive(Text("삭제")) {
                            //댓글삭제하는 함수 넣기
                        },
                      secondaryButton: .cancel(Text("취소")))
            }
        

    }
}

struct StudyReplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudyReplyDetailView(isEditing: .constant(true), userId: "성은", comment: StudyGroupComment(userId: "성은", content: "최악의 스터디 소개글이네여 ;;"))
    }
}
