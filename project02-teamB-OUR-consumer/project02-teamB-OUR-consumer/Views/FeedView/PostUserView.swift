//
//  PostUserView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct PostUserView: View {
    @ObservedObject var idData: IdData = IdData()
    var post: Post
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        ForEach (idData.idStore) { user in
            if post.creator == user.userID {
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
                                HStack {
                                    Text("\(user.name)")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                        .bold()
                                    Text("following")
                                        .font(.system(size: 12))
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Text("5일 전")
                                    .font(.system(size: 12))
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    .sheet(isPresented: $isShowingSheet) {
                        SheetView(idStore: user)
                            .presentationDetents([.medium, .medium])
                    }
                }
            }
        }
    }
}
struct PostUserView_Previews: PreviewProvider {
    static var previews: some View {
        PostUserView(idData: IdData(), post: Post.samplePost, isShowingSheet: .constant(false))
    }
}
