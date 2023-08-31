//
//  MyBoardView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct MyBoardView: View {
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    @State private var isShowingSheet: Bool = false
    @State private var isShowingPostOptionSheet: Bool = false
    @State private var isScrapFeed: Bool = false
    @State private var isShowingModifyDetailView: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(postViewModel.posts) { post in
                    VStack {
                        HStack {
                            PostUserView(post: post, isShowingSheet: $isShowingSheet)
                                
                            Button {
                                isShowingPostOptionSheet.toggle()
                            } label: {
                                Image(systemName: "ellipsis")
                                    .padding(2)
                            }
                            .foregroundColor(.gray)
                        }
                        .padding()
                        PostView(post: post, isScrapFeed: $isScrapFeed)
                        
    //                    PostButtonView(post: post, isScrapFeed: $isScrapFeed)
                        
                    }
//                    .sheet(isPresented: $isShowingPostOptionSheet) {
//                        PostOptionView(post: post, isShowingPostOptionSheet: $isShowingPostOptionSheet, isShowingModifyDetailView: $isShowingModifyDetailView)
//                                        .presentationDetents([.height(350), .height(350)])
//                    }
                    Rectangle()
                        .fill(Color("DefaultGray"))
                }
                
            }
        }
        .onAppear {
            postViewModel.getMyPosts()
        }
    }
}

struct MyBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MyBoardView()
    }
}
