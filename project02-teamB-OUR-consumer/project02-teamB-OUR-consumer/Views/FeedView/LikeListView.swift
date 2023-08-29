//
//  LikeListView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/29.
//

import SwiftUI

struct LikeListView: View {
    @ObservedObject private var idData: IdData = IdData()
    @State private var isToggle: Bool = false
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Like List")
                    .font(.system(size: 20))
                ForEach(idData.idStore) { like in
                    HStack{
                        Image("\(like.profileImgString)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 40)
                            .padding(.trailing, 10)
                        Text("\(like.name)")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        
                        Button {
                            idData.followToggle(like)
                        } label: {
                            if !like.isFollow {
                                FollowButtonView()
                            } else {
                                FollowingButtonView()
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
            }
            .padding()
        }
    }
}

struct LikeListView_Previews: PreviewProvider {
    static var previews: some View {
        LikeListView()
    }
}
