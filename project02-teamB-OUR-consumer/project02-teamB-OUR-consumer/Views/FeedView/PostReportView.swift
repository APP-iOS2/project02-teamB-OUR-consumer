//
//  PostReportView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/30.
//

import SwiftUI

struct PostReportView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue)

    let reports: [Report] = Report.reasons
    @State var showAlert: Bool = false
    @State var showToast: Bool = false
    @State var reportCategory: String = ""
    
    var post: Post
    @State var postModel: PostModel = PostModel.samplePostModel
    @EnvironmentObject var postViewModel: PostViewModel
    @Binding var isShowingPostReportView: Bool
    
    var body: some View {
        Form {
            Text("신고 사유")
                .font(.system(size: 30))
                .fontWeight(.black)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 0))
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
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("신고하시겠습니까?"),
                  message: Text("\"\(reportCategory)\" 사유로 신고합니다"),
                  primaryButton: .destructive(Text("신고하기")) {
                
                postViewModel.reportPost(postId: post.id ?? "", report: reportCategory)
                
                dismiss()
//                showToast.toggle()
            },
                  secondaryButton: .cancel(Text("취소")))
        }
    }
}

struct PostReportView_Previews: PreviewProvider {
    static var previews: some View {
        PostReportView(post: Post.samplePost, isShowingPostReportView: .constant(true))
    }
}
