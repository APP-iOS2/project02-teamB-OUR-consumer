//
//  StudyReplyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI

struct StudyReplyDetailView: View {
    
    @State var userViewModel: UserViewModel = UserViewModel()
    @StateObject var studyViewModel: StudyViewModel
    var comment: StudyComment

    
    // studycomment니까 실제로 댓글 달면 studygroupcomment로 달아줘야겠죠?? 다시 디비로 보낼때도 변환하는 과정이 필요합니다!!
    
    @State var index: Int
    
    @State var isShowingProfileSheet: Bool = false
    @Binding var showAlert: Bool

    var body: some View {
        LazyVStack {
            HStack {
                Button {
                    isShowingProfileSheet = true
                } label: {
                    if comment.user.profileImage != nil {
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
                .sheet(isPresented: $isShowingProfileSheet) {
                    SheetView(user: comment.user, userViewModel: userViewModel)
                        .presentationDetents([.medium, .medium])
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
                    if comment.isMine {
                        Button {
                            showAlert = true
                            studyViewModel.alertCase = .commentDelete
                            studyViewModel.selectedComment = comment
                        } label: {
                            Text("삭제하기")
                        }
                    } else {
                        NavigationLink {
                            StudyReportView(viewModel: studyViewModel, isStudy: false, comment: comment)
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
    }
}

struct StudyReplyDetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        StudyReplyDetailView(studyViewModel: StudyViewModel(), comment: StudyComment(user: User.defaultUser, content: "", createdAt: ""), index: 0, showAlert: .constant(false))
        
    }
}
