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
                                .stroke(Color("AccentColor"), lineWidth: 2)
                                .frame(height: 80)
                                .foregroundColor(Color.clear)
                                .shadow(radius: 8)
                                
                            Image(systemName: "person.2")
                                .font(.largeTitle)
                                .foregroundColor(Color("AccentColor"))
                        }
                        Spacer()
                        Text("스터디 모집")
                            .foregroundColor(Color.black)
                            .font(.title2)
                    }
                    .padding()
                }
                .fullScreenCover(isPresented: $isShowToggle, content: {
                    AddStudyMain(startDate: Date(), dueDate: Date())
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
                                .stroke(Color("AccentColor"), lineWidth: 2)
                                .frame(height: 80)
                                .foregroundColor(Color.clear)
                                .shadow(radius: 8)
                                
                            Image(systemName: "doc.text")
                                .font(.largeTitle)
                                .foregroundColor(Color("AccentColor"))
                        }
                        Spacer()
                        Text("피드 등록")
                            .foregroundColor(Color.black)
                            .font(.title2)
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
            .padding(20)
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
