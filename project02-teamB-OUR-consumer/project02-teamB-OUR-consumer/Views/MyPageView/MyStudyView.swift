//
//  MyStudyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct MyStudyView: View {
    var study: Study = Study(imageURL: URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuIT6b%2FbtrpDLcBnAW%2FFX4WsB9SKTiCxZlreaDjM0%2Fimg.png")!, title: "강남역에서 2시간 빡코딩해요!", date: "8월 25일 금 19:00", location: "강남역 스타벅스", isOnline: false, currentMemberCount: 1, totalMemberCount: 10)
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 3)
                            .frame(width: 160, height: 300)
                            .background(.white)
                            .shadow(radius: 6)
                            VStack {
                                AsyncImage(url: study.imageURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 130, height: 130)
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack(alignment: .leading) {
                                    Text("\(study.title)")
                                        .frame(width: 150, height: 50)
                                        .bold()
                                }
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(width: 100)
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "calendar.badge.clock")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 15, height: 15)
                                        Text("\(study.date)")
                                    }
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    HStack{
                                        Image(systemName: "person.3.sequence.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 19, height: 15)
                                        Text("\(study.currentMemberCount)/\(study.totalMemberCount)")
                                    }
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                }
                                NavigationLink {
                                    StudyDetailView()
                                } label: {
                                    Text("자세히 보기")
                                        .font(.system(size: 15))
                                        .frame(width: 100, height: 0)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(mainColor)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.leading)
            }
        }
    }
}

struct MyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        MyStudyView(study: Study(imageURL: URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuIT6b%2FbtrpDLcBnAW%2FFX4WsB9SKTiCxZlreaDjM0%2Fimg.png")!, title: "강남역에서 2시간 빡코딩해요!", date: "8월 25일 금 19:00", location: "강남역 스타벅스", isOnline: false, currentMemberCount: 1, totalMemberCount: 10))
    }
}
