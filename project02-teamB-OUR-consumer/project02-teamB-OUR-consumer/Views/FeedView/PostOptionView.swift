//
//  PostModifyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/25.
//

import SwiftUI

struct PostOptionView: View {
    
    var post: Post
    @State var postModel: PostModel = PostModel.samplePostModel
    
    @Binding var isShowingPostOptionSheet: Bool
    @Binding var isShowingModifyDetailView: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 30) {
                    Button {
                        isShowingPostOptionSheet = false
                        isShowingModifyDetailView.toggle()
                    } label: {
                        Label("수정", systemImage: "square.and.pencil")
                            .foregroundColor(Color(hex: 0x090580))
                    }
                }
                VStack(alignment: .leading, spacing: 30) {
                    Button {
                        //게시물 삭제 함수!!!
                        isShowingPostOptionSheet = false
                    } label: {
                        Label("삭제", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            .font(.title)
        }
    }
}

struct PostModifyView_Previews: PreviewProvider {
    static var previews: some View {
        PostOptionView(post: Post.samplePost, isShowingPostOptionSheet: .constant(false), isShowingModifyDetailView: .constant(false))
    }
}
