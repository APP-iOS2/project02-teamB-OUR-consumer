//
//  StudyListItemView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/22.
//

import SwiftUI

struct StudyListItemView: View {
    
    var study: Study
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: study.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            
            
            VStack(alignment: .leading) {
                Text(study.title)
                    .bold()
                    .lineLimit(1)
                    .padding(.bottom)
                VStack(alignment: .leading) {
                    Text(study.date)
                    Text(study.location)
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text("\(study.currentMemberCount)/\(study.totalMemberCount)")
                    }
                }
                .font(.caption)
                .bold()
                .foregroundColor(.gray)
            }
        }
        .frame(width: 350, height: 100)
        .padding()
        .background(
           RoundedRectangle(cornerRadius: 20)
               .foregroundColor(.white)
               .shadow(color: .gray, radius: 3, x: 1, y: 1)
               .opacity(0.3)
           )
        .padding()
    }
}

struct StudyListItemView_Previews: PreviewProvider {
    static var previews: some View {
        StudyListItemView(study: Study(imageURL: URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuIT6b%2FbtrpDLcBnAW%2FFX4WsB9SKTiCxZlreaDjM0%2Fimg.png")!, title: "강남역에서 2시간 빡코딩해요!", date: "8월 25일 금 19:00", location: "강남역 스타벅스", isOnline: false, currentMemberCount: 1, totalMemberCount: 10))
    }
}
