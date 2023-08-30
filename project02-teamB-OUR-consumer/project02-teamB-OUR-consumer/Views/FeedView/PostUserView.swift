//
//  PostUserView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/23.
//

import SwiftUI

struct PostUserView: View {
    var post: Post
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
                        HStack {
                            Text("\(post.creator)")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .bold()
                        }
                    }
                }
                Spacer()
            }
            //                    .sheet(isPresented: $isShowingSheet) {
            //                        SheetView(idStore: user)
            //                            .presentationDetents([.medium, .medium])
            //                    }
        }
        
        
    }
}
struct PostUserView_Previews: PreviewProvider {
    static var previews: some View {
        PostUserView(post: Post.samplePost, isShowingSheet: .constant(false))
    }
}
