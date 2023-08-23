//
//  StudyListItemView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/22.
//

import SwiftUI

struct StudyListItemView: View {
    
    var study: Study
    
    @State var addBookmark: Bool = false
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: study.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            
            
            VStack(alignment: .leading) {
                Text(study.title)
                    .bold()
                    .foregroundColor(.black)
                    .lineLimit(2)
                VStack(alignment: .leading, spacing: 5) {
                    Text(study.date)
                    Text(study.location)
                }
                .font(.caption)
                .bold()
                .foregroundColor(.gray)
                
                HStack {
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text("\(study.currentMemberCount)/\(study.totalMemberCount)")
                    }
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button {
                        addBookmark.toggle()
                    } label: {
                        Label("", systemImage: addBookmark ? "bookmark.fill" : "bookmark")
                            .font(.title2)
                            .foregroundColor(Color(red: 251 / 255, green: 55 / 255, blue: 65 / 255))
                    }
                }
            }
        }
        .frame(width: 350, height: 80)
        .padding()
        .background(
           RoundedRectangle(cornerRadius: 20)
               .foregroundColor(.white)
               .shadow(color: .gray, radius: 3, x: 1, y: 1)
               .opacity(0.3)
           )
        .padding([.leading, .trailing])
    }
}

struct StudyListItemView_Previews: PreviewProvider {
    static var previews: some View {
        StudyListItemView(study: Study(imageURL: URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuIT6b%2FbtrpDLcBnAW%2FFX4WsB9SKTiCxZlreaDjM0%2Fimg.png")!, title: "강남역에서 2시간 빡코딩해요!", date: "8월 25일 금 19:00", location: "강남역 스타벅스", isOnline: false, currentMemberCount: 1, totalMemberCount: 10))
    }
}
