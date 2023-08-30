//
//  FeedView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @State private var isShowingSheet: Bool = false
    @State private var isShowingPostOptionSheet: Bool = false
    @State private var isScrapFeed: Bool = false
    @State private var isShowingModifyDetailView: Bool = false
    @State private var isShowingPostReportView: Bool = false
    
    var body: some View {
        VStack {
            ForEach(postViewModel.posts) { post in
                VStack {
                    HStack {
                        PostUserView(post: post, postViewModel: postViewModel, isShowingSheet: $isShowingSheet)
                            
                        Button {
                            isShowingPostOptionSheet.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .padding(2)
                        }
                        .foregroundColor(.gray)
                    }
                    .padding()
                    PostView(post: post, postViewModel: postViewModel)
                    
                    PostButtonView(post: post, postViewModel: postViewModel, isScrapFeed: $isScrapFeed)
                    
                    Divider()
                        .frame(height: 4)
                        .overlay((Color("FeedViewDividerColor")))
                }
                .sheet(isPresented: $isShowingPostOptionSheet) {
                    PostOptionView(post: post, isShowingPostOptionSheet: $isShowingPostOptionSheet, isShowingModifyDetailView: $isShowingModifyDetailView)
                                    .presentationDetents([.height(220), .height(220)])
                }
                .sheet(isPresented: $isShowingModifyDetailView) {
                    PostModifyDetailView(post: post, postViewModel: postViewModel, isShowingModifyDetailView: $isShowingModifyDetailView)
                }
            }
        }
        .onAppear{
            postViewModel.fetchPostForCurrentUserFollower(limit: 3)
        }
        .refreshable {
            postViewModel.fetchPostForCurrentUserFollower(limit: 3)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        
        FeedView()
    }
}
