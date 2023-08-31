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
            VStack {
                Divider()
                VStack {
                    Button {
                        isShowingModifyDetailView.toggle()
                    } label: {
                        HStack {
                            ZStack {
                                Circle()
                                    .stroke(Color("AccentColor"), lineWidth: 2)
                                    .frame(height: 80)
                                    .foregroundColor(Color.clear)
                                    .shadow(radius: 8)
                                
                                Image(systemName: "square.and.pencil")
                                    .font(.largeTitle)
                                    .foregroundColor(Color("AccentColor"))
                            }
                            Spacer()
                            Text("수정")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title2)
                        }
                        .padding()
                    }
                    .fullScreenCover(isPresented: $isShowingModifyDetailView) {
                        PostModifyDetailView(post: post, isShowingModifyDetailView: $isShowingModifyDetailView)
                    }
                }
                Divider()
                VStack {
                    Button {
                        //게시물 삭제 함수!!!
                        isShowingPostOptionSheet = false
                    } label: {
                        HStack {
                            ZStack {
                                Circle()
                                    .stroke(Color(.red), lineWidth: 2)
                                    .frame(height: 80)
                                    .foregroundColor(Color.clear)
                                    .shadow(radius: 8)
                                
                                Image(systemName: "trash")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                            Spacer()
                            Text("삭제")
                                .foregroundColor(.red)
                                .font(.title2)
                        }
                        .padding()
                    }
                    Divider()
                }
            }
            .padding()
        }
    }
}

struct PostModifyView_Previews: PreviewProvider {
    static var previews: some View {
        PostOptionView(post: Post.samplePost, isShowingPostOptionSheet: .constant(false), isShowingModifyDetailView: .constant(false))
    }
}
