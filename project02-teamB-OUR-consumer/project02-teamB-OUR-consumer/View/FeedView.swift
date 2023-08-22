//
//  FeedView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedView: View {

    var body: some View {
        VStack {
            HStack {
                Image("Jun")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                VStack(alignment: .leading) {
                    HStack {
                        Text("@leeseungjun")
                            .bold()
                        Text("following")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    HStack {
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
                Image("Jun")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 70, height: 80)
                VStack(alignment: .leading) {
                    HStack {
                        Text("@leeseungjun")
                        HStack {
                            Text("10m ago")
                            Text("Reply")
                        }
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("유익합니다.")
                         
                    }
                }
                Spacer()
            }
            .background(.green)
            
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
            .foregroundColor(.indigo)
            .padding()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
