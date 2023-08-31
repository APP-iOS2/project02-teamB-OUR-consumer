//
//  CommentView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct CommentDetailView: View {
    var comment: PostComment
    
    @State var isShowingAlert: Bool = false
    @Binding var isModifyComment: Bool
    
    var body: some View {
        HStack {
            Image("OUR_Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(.gray)
                .clipShape(Circle())
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                HStack {
                    Text("\(comment.userId)")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    HStack {
                        Text("\(comment.createdAt)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
//                    .foregroundColor(Color(hex: 0x090580))
                }
                HStack {
                    Text("\(comment.content)")
                        .font(.system(size: 14))
                }
            }
            Spacer()
//            Menu {
//                if comment.userId == userId {
//                    Button {
//                        isModifyComment.toggle()
//                    } label: {
//                        Text("수정하기")
//                    }
//                    // 삭제 : 포스트 아이디가 같은경우도 !!해보기
//                    Button {
//                        isShowingAlert = true
//                        //삭제하는 func 만들어서 호출은 alert에서
//                    } label: {
//                        Text("삭제하기")
//                    }
//                } else {
//                    NavigationLink {
////                        StudyCommentReportView(userId: userId, comment: comment)
//                        // 중복해서 또 만들지 말지 모르니까 일단 보류
//                    } label: {
//                        Text("신고하기")
//                            .foregroundColor(.red)
//                    }
//                }
//            } label: {
//                Image(systemName: "ellipsis")
//            }
//            .foregroundColor(.gray)
        }
        .padding()
//        .background(Color("FeedViewBackgroundColor"))
        // 댓글 삭제 버튼
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("정말 삭제하겠습니까?"),
                      message: Text("댓글을 삭제합니다"),
                      primaryButton: .destructive(Text("삭제")) {
                            //댓글삭제하는 함수 넣기
                
                        },
                      secondaryButton: .cancel(Text("취소")))
            }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentDetailView(comment: PostComment(userId: "leeseungjun", content: "안녕하세요"), isModifyComment: .constant(false))
    }
}
