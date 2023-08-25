//
//  RecruitButton.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct RecruitButton: View {
    @State var isShowToggle: Bool = false
    @State var isShowToggle1: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                Button {
                    isShowToggle.toggle()
                } label: {
                    HStack {
                        ZStack {
                            Circle()
                                .frame(height: 80)
                                .foregroundColor(Color.gray)
                                .shadow(radius: 8)
                            Image(systemName: "person.2")
                                .font(.largeTitle)
                                .foregroundColor(Color.black)
                        }
                        Spacer().frame(width: 140)
                        Text("스터디 모집")
                            .foregroundColor(Color.black)
                            .font(.title2)
                        Spacer().frame(width: 30)
                    }
                    .padding()
                    
                }
                .fullScreenCover(isPresented: $isShowToggle, content: {
                    AddStudyMain(startDate: Date(), endDate: Date(), startTime: Date())
                })
//                .navigationDestination(isPresented: $isShowToggle) {
//                    AddStudyMain()
//                }
                Divider()
                Button {
                    isShowToggle1.toggle()
                } label: {
                    HStack {
                        ZStack {
                            Circle()
                                .frame(height: 80)
                                .foregroundColor(Color.gray)
                                .shadow(radius: 8)
                            Image(systemName: "doc.text")
                                .font(.largeTitle)
                                .foregroundColor(Color.black)
                        }
                        Spacer().frame(width: 129)
                        Text("피드 작성하기")
                            .foregroundColor(Color.black)
                            .font(.title2)
                        Spacer().frame(width: 17)
                    }
                    .padding()
                }
                .fullScreenCover(isPresented: $isShowToggle1, content: {
                    FeedRecruitView()
                })
//                .navigationDestination(isPresented: $isShowToggle1) {
//                    FeedRecruitView()
//                }
            }
        }
    }
}

struct RecruitButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecruitButton()
        }
    }
}
