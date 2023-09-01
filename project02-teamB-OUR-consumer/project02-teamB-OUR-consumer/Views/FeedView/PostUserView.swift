//
//  PostUserView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct PostUserView: View {
//    var user: User
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    var post: Post
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @Binding var isShowingSheet: Bool
    @State private var isShowingPostOptionSheet: Bool = false
    @State private var isShowingPostReportView: Bool = false
    @State private var isShowingModifyDetailView: Bool = false
    
    var body: some View {
        
        HStack {
            Button {
                isShowingSheet.toggle()
            } label: {
                HStack {
                    Image("OUR_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.gray)
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        Text("\(postViewModel.postModel.creator.name)")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .bold()
                        Text("\(postViewModel.postModel.location)")
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Button {
                    if post.creator == "eYebZXFIGGQFqYt1fI4v4M3efSv2" {
                        isShowingPostOptionSheet.toggle()
                    } else {
                        isShowingPostReportView.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .padding(2)
                }
                .foregroundColor(.gray)
            }
            .sheet(isPresented: $isShowingSheet) {
                SheetView(user: postViewModel.postModel.creator, post: post)
                    .presentationDetents([.height(300), .height(300)])
            }
            // 수정, 삭제
            .sheet(isPresented: $isShowingPostOptionSheet) {
                PostOptionView(post: post, isShowingPostOptionSheet: $isShowingPostOptionSheet, isShowingModifyDetailView: $isShowingModifyDetailView)
                    .presentationDetents([.height(350), .height(350)])
            }
            // 신고
            .sheet(isPresented: $isShowingPostReportView) {
                PostReportView(post: post, isShowingPostReportView: $isShowingPostReportView)
                    .presentationDetents([.height(300), .height(300)])
            }
        }
        .onAppear {
            postViewModel.getPost(of: post)
        }
    }
}
struct PostUserView_Previews: PreviewProvider {
    static var previews: some View {
        PostUserView(post: Post.samplePost, isShowingSheet: .constant(false))
            .environmentObject(PostViewModel())
    }
}
