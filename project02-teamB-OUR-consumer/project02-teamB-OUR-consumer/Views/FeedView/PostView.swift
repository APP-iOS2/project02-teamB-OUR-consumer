//
//  PostView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct PostView: View {
    
    var post: Post
    @StateObject var postViewModel: PostViewModel
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @State var isSpreadBtn: Bool = false
    @State var lineLimitNumber: Int = 2
    @State private var isSheet: Bool = false
 
    var body: some View {
        Group {
            if post.postImagePath.isEmpty == false {
                TabView {
                    ForEach(postModel.postImagePath, id: \.self) { imagePath in
                        AsyncImage(url: URL(string: imagePath)) { image in
                            image
                                .resizable()
                                .frame(height: 400)
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 350)
            }
 
            VStack(alignment: .leading) {
                HStack(alignment: .bottom, spacing: 10) {
                    Text("\(post.content)")
                        .font(.system(size: 16))
                        .lineLimit(lineLimitNumber)
                    Button {
                        isSpreadBtn.toggle()
                        lineLimitNumber = isSpreadBtn ? 10 : 2
                    } label: {
                        Text("\(isSpreadBtn ? "접기" : "더보기")")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                HStack() {
                    Text("\(post.createdAt)")
                    Spacer()
                    Button {
                        isSheet.toggle()
                    } label: {
                        Text("좋아요 \(postModel.numberOfLike)")
                    }
                    .sheet(isPresented: $isSheet) {
                        LikeListView(post: post, postViewModel: postViewModel, isToggle: $isSheet)
                    }
         
//                    Text("댓글 \(postModel.numberOfComments)")
//                    Text("퍼감 \(postModel.numberOfRepost)")
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding()
            }
        }
        .onAppear {
            postViewModel.getPost(of: post) { postmodel in
                self.postModel = postmodel
            }
        }
        
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostView(post: Post.samplePost, postViewModel: PostViewModel())
        }
    }
}
