//
//  PostReportView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/30.
//

import SwiftUI

struct PostReportView: View {
    var post: Post
    @State var postModel: PostModel = PostModel.samplePostModel
    @Binding var isShowingPostReportView: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PostReportView_Previews: PreviewProvider {
    static var previews: some View {
        PostReportView(post: Post.samplePost, isShowingPostReportView: .constant(false))
    }
}
