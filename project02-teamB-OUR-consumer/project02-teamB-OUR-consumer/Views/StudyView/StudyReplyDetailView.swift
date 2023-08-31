//
//  StudyReplyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI

struct StudyReplyDetailView: View {
    
    @StateObject var studyViewModel: StudyViewModel
    var userViewModel: UserViewModel
    var comment: StudyComment
    
    // studycomment니까 실제로 댓글 달면 studygroupcomment로 달아줘야겠죠?? 다시 디비로 보낼때도 변환하는 과정이 필요합니다!!
    
    //마이페이지에서 가져온 유저네임으로 바꾸기~
//    var UserId: String = "test"
    
    @State var index: Int
    
    @Binding var editComment: String
    @Binding var isEditing: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        LazyVStack {
            HStack {
                Button {
                    //해당 프로필 시트 올려주는 ~
                } label: {
                    if comment.user.profileImage != nil {
                        //프로필이미지도
                        Image(comment.user.profileImage ?? "OUR_Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .clipShape(Circle())
                    } else {
                        Image("OUR_Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .clipShape(Circle())
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 5){
                    HStack {
                        Text(comment.user.name)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        Text(comment.createdAt)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                    }
                    Text(comment.content)
                        .font(.system(size: 14))
                    
                }
                Spacer()
                
                Menu {
                    if comment.user.id == userViewModel.user?.id  {
                        Button {
                            isEditing = true
                            editComment = comment.content
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
                            StudyCommentReportView(viewModel: studyViewModel, isStudy: false, comment: comment)
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
                //댓글 삭제 함수 자리
            },
                  secondaryButton: .cancel(Text("취소")))
        }
        
        
    }
}

struct StudyReplyDetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        StudyReplyDetailView(studyViewModel: StudyViewModel(), userViewModel: UserViewModel(), comment: StudyComment(user: User.defaultUser, content: "", createdAt: ""), index: 0, editComment: .constant(""), isEditing: .constant(false))
        
    }
}
