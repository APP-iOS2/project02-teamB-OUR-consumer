//
//  FeedView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var postData: PostData = PostData()
    @State private var isShowingSheet: Bool = false
    @State private var isShowingPostModifySheet: Bool = false
    var body: some View {
        ForEach(postData.postStore) { post in
            VStack {
                HStack {
                    PostUserView(post: post, isShowingSheet: $isShowingSheet)
                    Button {
                        isShowingPostModifySheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .padding(2)
                    }
                    .foregroundColor(.gray)

                }
                PostView(post: post)
                PostButtonView(post: post, postData: postData)
                Divider()
                    .frame(height: 4)
                    .overlay((Color("FeedViewDividerColor")))
                    
            }
            .padding()
            .sheet(isPresented: $isShowingPostModifySheet) {
                PostModifyView(isShowingPostModifySheet: $isShowingPostModifySheet)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
