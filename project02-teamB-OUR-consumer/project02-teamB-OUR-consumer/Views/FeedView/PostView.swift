//
//  PostView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/22.
//

import SwiftUI

struct PostView: View {
    
    var post: Post
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    @State private var postModel: PostModel = PostModel.samplePostModel
    var postFireService: PostFireService = PostFireService()
    
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
                    ForEach(postViewModel.postModel.postImagePath, id: \.self) { imagePath in
                        AsyncImage(url: URL(string: imagePath)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 600)
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 550)
                //                .background(Color.black)
            }
            
            VStack(alignment: .leading) {
                HStack(alignment: .bottom, spacing: 10) {
                    Text("\(post.content)")
                        .font(.system(size: 16))
                        .lineLimit(lineLimitNumber)
                    
                    if post.content.count > 30 {
                        Button {
                            isSpreadBtn.toggle()
                            lineLimitNumber = isSpreadBtn ? 10 : 1
                        } label: {
                            Text("\(isSpreadBtn ? "접기" : "더보기")")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
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
                            .padding(.trailing, 10)
                    }
                    .sheet(isPresented: $isSheet) {
                        LikeListView(post: post, postViewModel: postViewModel,  isToggle: $isSheet)
                    }
                    
                    Button {
                        isShowingCommentSheet.toggle()
                    } label: {
                        Text("댓글 \(postViewModel.postModel.numberOfComments)")
                    }
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
                    postViewModel.postModel.isLiked.toggle()
                    if postViewModel.postModel.isLiked {
                        postViewModel.postModel.numberOfLike += 1
                    } else {
                        postViewModel.postModel.numberOfLike -= 1
                    }
                    print("\(postViewModel.postModel.isLiked)")
                    
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
            postViewModel.getPost(of: post)
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
