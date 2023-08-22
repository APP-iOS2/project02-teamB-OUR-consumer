//
//  StudyReplyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI

struct StudyReplyDetailView: View {
    
    var userId: String
    var comment: StudyGroupComment
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    //해당 프로필 시트 올려주는 ~
                } label: {
                    comment.profileImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 55)
                        .clipShape(Circle())
                }

                
                VStack(alignment: .leading, spacing: 5){
                    HStack {
                        Text(comment.userId)
                            .fontWeight(.bold)
                        Text(comment.createdDate)
                            .font(.footnote)
                    }
                    Text(comment.content)
                    
                }
                Spacer()
                
                Menu {
                    if comment.userId == userId {
                        Button {
                            //수정하기
                        } label: {
                            Text("수정하기")
                        }
                        
                        Button {
                            //삭제하는 func 만들기~
                        } label: {
                            Text("삭제하기")
                        }
                    } else {
                        Button {
                            //신고뷰
                        } label: {
                            Text("신고하기")
                                .foregroundColor(.red)
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
                .foregroundColor(.gray)
            }
        }

    }
}

struct StudyReplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudyReplyDetailView(userId: "성은", comment: StudyGroupComment(userId: "성은", content: "최악의 스터디 소개글이네여 ;;"))
    }
}
