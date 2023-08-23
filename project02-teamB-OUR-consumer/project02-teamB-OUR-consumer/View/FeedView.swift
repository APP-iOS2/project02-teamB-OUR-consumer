//
//  FeedView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedView: View {
    var idStore : IdStore = IdStore(id: UUID(), name: "이승준", profileImgString: "Jun", userID: "leeseungjun", numberOfPosts: 120, numberOfFollowrs: 50000, numberOfFollowing: 4, numberOfComments: 100, profileMessage: "안녕하세요 이승준입니다.")
    
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    isShowingSheet.toggle()
                } label: {
                    VStack {
                        HStack {
                            Image("\(idStore.profileImgString)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                            
                            Text("\(idStore.name)")
                                .bold()
                            Text("following")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        Text("5일 전")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                    
                    
                Spacer()
            }
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    Text("축구... 어렵네...")
                    Button {
                        // 피드 내용 펼치기
                    } label: {
                        Text("더보기")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                HStack() {
                    Spacer()
                    Button {
                        // 좋아요 버튼
                    } label: {
                        Text("좋아요 100")
                    }
                    Button {
                        // 댓글 버튼
                    } label: {
                        Text("댓글 5")
                    }
                    Button {
                        // 퍼감 버튼
                    } label: {
                        Text("퍼감 2")
                    }
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
            }
            // Reply
            HStack {
                Image("")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(.gray)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Riya Jain")
                        HStack {
                            Text("10m ago")
                            Text("Reply")
                        }
                        .font(.footnote)
                        .foregroundColor(Color(hex: 0x090580))
                    }
                    HStack {
                        Text("유익합니다.")
                        
                    }
                }
                Spacer()
            }
            //            .background(Color(hex: F1F2FA))
            
            HStack(spacing: 75) {
                Button {
                    // 좋아요 버튼
                } label: {
                    Image(systemName: "hand.thumbsup")
                }
                Button {
                    // 댓글 버튼
                } label: {
                    Image(systemName: "bubble.left")
                }
                Button {
                    // 퍼감 버튼
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
                Button {
                    // 공유 버튼
                } label: {
                    Image(systemName: "arrowshape.turn.up.right")
                }
                
            }
            .font(.title2)
            .bold()
            .foregroundColor(Color(hex: 0x090580))
            .padding()
            
            .sheet(isPresented: $isShowingSheet) {
                SheetView(idStore: idStore)
                    .presentationDetents([.medium, .medium])
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
