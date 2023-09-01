//
//  StudyCommentReportView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/23.
//

import SwiftUI

struct StudyReportView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    //    var commentUserId: String // 신고하는 사람..?
    var viewModel: StudyViewModel
    var isStudy: Bool
    var comment: StudyComment?
    let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue)
    
    //신고유형들 쭈루룩
    //경미님이 짜준 enum 올라오면 활용하기
    let reports: [Report] = Report.reasons
    
    @State var showAlert: Bool = false
    @State var reportCategory: String = ""
    
    
    var body: some View {
        NavigationStack {
            Divider()
            //            VStack(alignment: .leading) {
            //                Text("신고하는 댓글")
            //                    .fontWeight(.heavy)
            //
            //                StudyReplyDetailInReportView(comment:comment)
            //                    .padding(10)
            //                    .overlay(
            //                            RoundedRectangle(cornerRadius: 20)
            //                                .stroke(Color.gray, lineWidth: 0.5)
            //                        )
            //            }
            //
            //            Divider()
            
            Form {
                Text("신고하는 이유")
                    .fontWeight(.heavy)
                    .padding([.bottom, .top], 5)
                ForEach(reports, id: \.self) { report in
                    Button {
                        showAlert = true
                        reportCategory = Report.getReport(for: report)
                    } label: {
                        Text("\(Report.getReport(for: report))")
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
            Alert(title:  Text("\"\(reportCategory)\" 사유로 신고합니다"),
                  primaryButton: .destructive(Text("신고하기")) {
                if isStudy {
                    guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
                        return
                    }
                    Task {
                        await viewModel.reportStudy(report: ReportData(reason: reportCategory, userId: userId))
                    }
                }
                dismiss()//뷰 닫기
            },
                  secondaryButton: .cancel(Text("취소")))
        }
    }
}

struct StudyCommentReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            StudyReportView(viewModel: StudyViewModel(), isStudy: true)
        }
    }
}
