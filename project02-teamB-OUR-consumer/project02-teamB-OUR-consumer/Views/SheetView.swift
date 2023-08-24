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
    var idStore: IdStore
    var frameWidth: Double = 400
    var frameHeight: Double = 120
    var frameCornerRadius: Double = 25
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(idStore.profileImgString)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                        .border(Color.gray, width: 4)
                        .padding(.leading, 30)
                        .clipShape(Circle())
                }

                Button {
                    
                } label: {
                    Group {
                        Text("@")
                            .padding(.leading, -30)
                        Text(idStore.userID)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .padding(.leading, -20)
                    }
                    .foregroundColor(Color.black)
                    .font(.title3)
                    .bold()
                }

                Spacer()
            }
            HStack {
                VStack {
                    HStack {
                        Text(idStore.name)
                            .font(.system(size: 16))
                            .bold()
                            .padding(.leading, 33)
                        Spacer()
                    }
                    HStack {
                        Text(idStore.profileMessage)
                            .font(.system(size: 14))
                            .padding(.leading, 33)
                            .foregroundColor(Color(hex: 0x090580))
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            ZStack {
                                FollowBtnView()
                                    .foregroundColor(Color(hex: 0x090580))
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            
            ZStack {
                HStack {
                    Spacer()
                    VStack {
                        Text(String(idStore.numberOfPosts))
                            .font(.title)
                            .bold()
                        Text("Posts")
                    }
                    Spacer()
                    VStack {
                        Text(String(idStore.numberOfFollowrs))
                            .font(.title)
                            .bold()
                        Text("Followers")
                    }
                    Spacer()
                    VStack {
                        Text(String(idStore.numberOfFollowing))
                            .font(.title)
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
                    .frame(width: 400, height: 50)
                    .background(Color(hex: 0x090580))
                    .cornerRadius(8)
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding()
            }

            
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(idStore: IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.", isFollow: false))
    }
}
