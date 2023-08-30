//
//  PostModifyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/25.
//

import SwiftUI

struct PostModifyView: View {
    
    var post: FeedStore
    
    @Binding var isShowingPostModifySheet: Bool
    @Binding var isShowingModifyDetailView: Bool
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 30) {
                Button {
                    isShowingPostModifySheet = false
                    isShowingModifyDetailView.toggle()
                } label: {
                    Label("수정", systemImage: "square.and.pencil")
                        .foregroundColor(Color(hex: 0x090580))
                }
            }
            VStack(alignment: .leading, spacing: 30) {
                Button {
                    //게시물 삭제 함수!!!
                    isShowingPostModifySheet = false
                } label: {
                    Label("삭제", systemImage: "trash")
                        .foregroundColor(.red)
                }
            }

        }
        .font(.title)
    }
}

struct PostModifyView_Previews: PreviewProvider {
    static var previews: some View {
        PostModifyView(post: FeedStore(id: UUID(), postId: "leeseungjun", numberOfComments: 3, numberOfLike: 23, numberOfRepost: 4, postImageString: "postImg2", content: "축구...어렵네..."), isShowingPostModifySheet: .constant(false), isShowingModifyDetailView: .constant(false))
    }
}
