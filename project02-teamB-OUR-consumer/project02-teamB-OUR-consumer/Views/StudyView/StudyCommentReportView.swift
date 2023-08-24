//
//  StudyCommentReportView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/23.
//

import SwiftUI

struct StudyCommentReportView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var userId: String
    var comment: StudyGroupComment
    
    //신고유형들 쭈루룩
    let reports: [String] = ["스팸","사기 또는 거짓", "혐오 발언 또는 상징", "계정이 해킹당 했을 수 있음"]
    
    @State var showAlert: Bool = false
    @State var reportCategory: String = ""
    
    @Binding var isEditing: Bool
    
    var body: some View {
        NavigationStack {
            Divider()
            VStack(alignment: .leading) {
                Text("신고하는 댓글")
                    .fontWeight(.heavy)
                StudyReplyDetailView(isEditing: $isEditing, userId: "성은", comment: comment)
                    .padding(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )

            }
            
            Divider()
            
            Form {
                Text("신고하는 이유")
                    .fontWeight(.heavy)
                    .padding([.bottom, .top], 5)
                ForEach(reports, id: \.self) { report in
                    
                    Button {
                        reportCategory = report
                        showAlert = true
                    } label: {
                        Text("\(report)")
                            .padding(.bottom, 5)
                        
                    }
                    .foregroundColor(.black)
                    Divider()
                    
                }
            }
            .formStyle(.columns)
            
            
            
            
            Spacer()
        }
        .navigationTitle("신고하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.backward")
        })
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("신고하시겠습니까?"),
                  message: Text("\"\(reportCategory)\" 사유로 신고합니다"),
                  primaryButton: .destructive(Text("신고하기")) {
                print(reportCategory)
                dismiss()//뷰 닫기
                //신고관련된 함수넣기
                    },
                  secondaryButton: .cancel(Text("취소")))
        }
    }
}

struct StudyCommentReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            StudyCommentReportView(userId: "성은", comment: StudyGroupComment(userId: "성은", content: "최악의 스터디 소개글이네여 ;;"), isEditing: .constant(true))
        }
    }
}
