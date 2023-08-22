//
//  StudyReplyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI

struct StudyReplyView: View {
    
    @State var isEditing: Bool = false
    
    @State var studyGroupComments: [StudyGroupComment] = [
        StudyGroupComment(userId: "유리", profileString: "yuriProfile", content: "1빠"),
        StudyGroupComment(userId: "지영", content: "최고의 스터디네요~"),
        StudyGroupComment(userId: "성은", content: "최악의 스터디 소개글이네여 ;;"),
        StudyGroupComment(userId: "소정", profileString: "sojungProfile", content: "오 안녕하세요")
    ]
    
    var userId: String = "성은"
    @State var content: String = ""
    
    var body: some View {
        NavigationStack{
            List {
                ForEach($studyGroupComments) { $comment in
                    StudyReplyDetailView(userId: "성은", comment: comment)
                }
            }
            .listStyle(.plain)
            .refreshable {
                //새로고침
            }
            
            
            HStack {
                Image("OUR_Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45)
                    .clipShape(Circle())
                if isEditing {
                    TextField("Edit reply",text: $studyGroupComments[2].content)
                        .onTapGesture {
                            studyGroupComments[2].content = ""
                        }
                    Button("Edit") {
                        studyGroupComments[2].content = content
                        //나중에 패치같은거하면 될듯 ~. .....아님... 뭐... 추후생각
                        isEditing = false
                    }
                } else {
                    TextField("Add reply", text: $content)
                    Button("Add") {
                        let comment: StudyGroupComment = StudyGroupComment(userId: "로그인된 유저아이디", content: content)
                        studyGroupComments.append(comment)
                        content = ""
                    }
                }
            }
            .padding()
            
        }
    }
}

struct StudyReplyView_Previews: PreviewProvider {
    @State var studyReplies: [String] = ["1빠", "2빠"]
    static var previews: some View {
        Form{
            Section("댓글") {
                StudyReplyView()
            }
        }
        .formStyle(.columns)
    }
}
