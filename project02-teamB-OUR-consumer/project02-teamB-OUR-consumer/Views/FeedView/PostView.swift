//
//  PostView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct PostView: View {
    
    var post: Post
    @EnvironmentObject var postViewModel: PostViewModel
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @State var isSpreadBtn: Bool = false
    @State var lineLimitNumber: Int = 2
    @State private var isSheet: Bool = false
    
    @State var isShowingCommentSheet: Bool = false
    @State var isShowingScrapSheet: Bool = false
    @State var isShowingShareSheet: Bool = false
    
    @Binding var isScrapFeed: Bool
 
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
                        Text("좋아요 \(postViewModel.postModel.numberOfLike)")
                    }
                    .sheet(isPresented: $isSheet) {
                        LikeListView(post: post, isToggle: $isSheet)
                    }
         
//                    Text("댓글 \(postModel.numberOfComments)")
//                    Text("퍼감 \(postModel.numberOfRepost)")
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding()
            }
            
            HStack(spacing: 75) {
                Button {
                    // 좋아요 버튼
                    postViewModel.likePost(postID: post.id ?? "")
                    postModel.isLiked.toggle()
                    if postModel.isLiked {
                        postModel.numberOfLike += 1
                    } else {
                        postModel.numberOfLike -= 1
                    }
                    print("\(postModel.isLiked)")

                } label: {
                    postViewModel.postModel.isLiked ? Image(systemName: "hand.thumbsup.fill") : Image(systemName: "hand.thumbsup")
                }
                Button {
                    isShowingCommentSheet.toggle()
                } label: {
                    Image(systemName: "bubble.left")
                }
                Button {
                    isShowingScrapSheet.toggle()
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                }
                // 쉐어링크 수정
                ShareLink(item: post.content) {
                    Label("", systemImage: "arrowshape.turn.up.right")
                }
            }
            .font(.title2)
            .bold()
            .foregroundColor(Color(hex: 0x090580))
            .padding()
            // 댓글 시트
            .sheet(isPresented: $isShowingCommentSheet) {
                CommentView(post: post)
            }
            // 퍼가기 시트
            .sheet(isPresented: $isShowingScrapSheet) {
                ScrapView(post: post, isShowingScrapSheet: $isShowingScrapSheet, isScrapFeed: $isScrapFeed)
                    .presentationDetents([.height(180), .height(180)])
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
            PostView(post: Post.samplePost, isScrapFeed: .constant(false))
                .environmentObject(PostViewModel())
        }
    }
}
