//
//  RecruitButton.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct RecruitButton: View {
    var body: some View {
        VStack {
            Divider()
            Button {
                
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
            Divider()
            Button {
                
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
        }
    }
}

struct RecruitButton_Previews: PreviewProvider {
    static var previews: some View {
        RecruitButton()
    }
}
