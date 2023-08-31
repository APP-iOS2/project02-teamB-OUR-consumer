//
//  PostUserView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct PostUserView: View {
    @State var user: User = User.defaultUser
    @State var userViewModel: UserViewModel = UserViewModel()
    var post: Post
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    
    @State private var postModel: PostModel = PostModel.samplePostModel
    
    @Binding var isShowingSheet: Bool
    
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
            }
            .sheet(isPresented: $isShowingSheet) {
                SheetView(user: user, userViewModel: userViewModel)
                    .presentationDetents([.medium, .medium])
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
