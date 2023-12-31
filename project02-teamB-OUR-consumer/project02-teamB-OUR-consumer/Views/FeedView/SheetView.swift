//
//  SheetView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

struct SheetView: View {
    var user: User
    var post: Post
    @State var postModel: PostModel = PostModel.samplePostModel
    @EnvironmentObject var postViewModel: PostViewModel
    
    var frameWidth: Double = 355
    var frameHeight: Double = 80
    var frameCornerRadius: Double = 25
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    HStack {
                        Image(user.profileImage ?? "OUR_Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .background(Color.gray)
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                        
                        Text("\(user.name)")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                    }
                    .foregroundColor(Color.black)
                    .font(.title3)
                    .bold()
                }
                Spacer()
//                Button {
//
//                } label: {
//                    ZStack {
//                        FollowingButtonView()
//                            .foregroundColor(Color(hex: 0x090580))
//                            .padding(.trailing, 10)
//                    }
//                }
            }
            .padding()
            HStack {
                VStack {
                    HStack {
                        Text(user.name)
                            .font(.system(size: 16))
                            .bold()
                            .padding(.leading, 33)
                        Spacer()
                    }
                    HStack {
                        Text(user.profileMessage ?? "")
                            .font(.system(size: 14))
                            .padding(.leading, 33)
                            .foregroundColor(Color(hex: 0x090580))
                        Spacer()
                    }
                }
                
                Spacer()
            }
            
            ZStack {
                HStack {
//                    Spacer()
//                    VStack {
//                        Text(String(user.numberOfPosts))
//                            .font(.title)
//                            .bold()
//                        Text("Posts")
//                    }
                    Spacer()
                    VStack {
                        Text("\(user.follower?.count ?? 0)")
                            .font(.system(size: 20))
                            .bold()
                        Text("Followers")
                    }
                    Spacer()
                    VStack {
                        Text("\(user.following?.count ?? 0)")
                            .font(.system(size: 20))
                            .bold()
                        Text("Following")
                    }
                    Spacer()
                }
                .frame(width: frameWidth - 4, height: frameHeight - 4)
                .background(Color.white)
                .cornerRadius(frameCornerRadius - 2)
            }
            .frame(width: frameWidth, height: frameHeight)
            .background(Color(hex: 0x090580))
            .cornerRadius(frameCornerRadius)
            
            Button {
                
            } label: {
                Text("프로필 방문하기")
                    .frame(width: 355, height: 40)
                    .background(Color(hex: 0x090580))
                    .cornerRadius(8)
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
                    .bold()
                    .padding()
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(user: User.defaultUser, post: Post.samplePost)
    }
}
