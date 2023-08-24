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
    
    var body: some View {
        ForEach(postData.postStore) { post in
            VStack {
                PostUserView(post: post, isShowingSheet: $isShowingSheet)
                PostView(post: post)
                PostButtonView(post: post, postData: postData)
                Divider()
                    .frame(height: 4)
                    .overlay((Color(hex: 0x090580)))
            }
            .padding()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
