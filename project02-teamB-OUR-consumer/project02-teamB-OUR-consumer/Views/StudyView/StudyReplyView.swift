//
//  StudyReplyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI

struct StudyComment: Identifiable {
    var id: UUID = UUID()
    var userId: String // 이것도 포스트아이디처럼 따로 받아와야되나?!
    var profileString: String?
    var content: String
    var createdAt: Double = Date().timeIntervalSince1970
    
    var profileImage: Image {
        Image(profileString ?? "OUR_Logo")
    }
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
}

class StudyCommentStore: ObservableObject {
    @Published var comments: [StudyComment] = []
    
    
    func fetchComments() {
        comments = [
            StudyComment(userId: "유리", profileString: "yuriProfile", content: "1빠"),
            StudyComment(userId: "지영", content: "최고의 스터디네요~"),
            StudyComment(userId: "성은", content: "최악의 스터디 소개글이네여 ;;"),
            StudyComment(userId: "소정", profileString: "sojungProfile", content: "오 안녕하세요")
        ]
    }
    
    func addComments(_ comment: StudyComment) {
        comments.append(comment)
        
        fetchComments()
    }
    
    func deleteComments(_ comment: StudyComment) {
        let commentId = comment.id
         
        var index: Int = 0
        
        for tempComment in comments {
            if tempComment.id == commentId {
                comments.remove(at: index)
                break
            }
            
            index += 1
        }
        
        fetchComments()
    }
}

struct StudyReplyView: View {
    
    @ObservedObject var studyCommentStore = StudyCommentStore()
    
    @State var editComment: String = ""
    @State var isEditing: Bool = false
    
    @State var content: String = ""
    @State var commentUserId: String = "성은"
    
    var body: some View {
        VStack{
            
            
            HStack() {
                Spacer()
                
                Text("댓글 \(studyCommentStore.comments.count)")
                    .font(.system(size: 14))
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.trailing, 20)
            
            Divider()
            
            //List {
            ForEach(studyCommentStore.comments) { comment in
                StudyReplyDetailView(commentUserId: commentUserId, studyCommentStore: studyCommentStore, comment: comment, isEditing: $isEditing)
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
                //댓글입력창
                if isEditing {
                    
                    TextField("Edit reply",text: $content)
                    //                        .onTapGesture {
                    //                            studyGroupComments[2].content = ""
                    //                        }
                    Button("Edit") {
                        
                        isEditing = false
                    }
                } else {
                    TextField("댓글을 입력하세요", text: $content, axis: .vertical)
                    Button("등록") {
                        let comment = StudyComment(userId: commentUserId, content: content)
                        studyCommentStore.comments.append(comment)
                        print("\(studyCommentStore.comments)")
                        content = ""
                    }
                }
            }
            .padding()
            
        }
        .onAppear {
            studyCommentStore.fetchComments()
        }
        
    }
}

struct StudyReplyView_Previews: PreviewProvider {
    @State var studyReplies: [String] = ["1빠", "2빠"]
    static var previews: some View {
        StudyReplyView(studyCommentStore: StudyCommentStore())
        
    }
}
