//
//  StudyListItemView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/22.
//

import SwiftUI

struct StudyListItemView: View {

    @ObservedObject var studyViewModel: StudyViewModel = StudyViewModel()
    
    @State var addBookmark: Bool = false
    
    var study: StudyDTO
    
    var body: some View {
        HStack(spacing: 20) {
            
            if study.imageString == nil {
                Image("OUR_Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            } else {
                AsyncImage(url: URL(string: study.imageString!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }

            }
            
            
            VStack(alignment: .leading) {
                Text(study.title)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(.black)
                    .lineLimit(2)
                VStack(alignment: .leading, spacing: 5) {
                    Text(study.studyDate)
                    Label(study.locationName ?? "", systemImage: "mappin.and.ellipse")
                }
                .font(.system(size: 12))
                .bold()
                .foregroundColor(.gray)
                
                HStack {
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text("\(study.currentMemberIds.count)/\(study.totalMemberCount)")
                    }
                    .font(.system(size: 12))
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
                    .buttonStyle(.plain)
                    //이거 왜되는가..?
                }
            }
        }
        .frame(width: 345, height: 90)
        .padding()
        .background(
           RoundedRectangle(cornerRadius: 20)
               .foregroundColor(.white)
               .shadow(color: .gray, radius: 3, x: 1, y: 1)
               .opacity(0.3)
           )
        .padding(.leading)
        .onAppear {
            studyViewModel.fetchStudy()
        }
    }
}

struct StudyListItemView_Previews: PreviewProvider {
    static var previews: some View {
        StudyListItemView(study: StudyDTO( creatorId: "", title: "iOS 개발자 면접", description: "", studyDate: "8월 24일", deadline: "8월 23일", isOnline: false, currentMemberIds: [""], totalMemberCount: 5, createdAt: "2023.08.28"))
    }
}
