//
//  MyStudyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct MyStudyView: View {
    @StateObject private var studyViewModel = StudyViewModel()
    var studyArray: [StudyDTO]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                /* 스터디 이미지 추가되면 진행 예정
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(studyViewModel.studyArray) { study in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 160, height: 300)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .foregroundColor(.white)
                                    .padding(2)
                                    .shadow(radius: 3)
                                
                                VStack {
//                                    AsyncImage(url: study.imageURL) { image in
//                                        image
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .frame(width: 130, height: 130)
//                                            .cornerRadius(10)
//                                    } placeholder: {
//                                        ProgressView()
//                                    }
                                    VStack(alignment: .leading) {
                                        Text("\(study.title)")
                                            .frame(width: 130, height: 50)
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
                                            VStack {
                                                VStack {
                                                    Text("\(study.studyDate)")
                                                        .frame(width: 110)
                                                        .lineLimit(1) //3줄까지만 제한을 둔다. ()안에 nil을 쓰면 무제한
                                                }
                                                .fixedSize(horizontal: false, vertical: true)
                                            }
                                        }
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        HStack{
                                            Image(systemName: "person.3.sequence.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 19, height: 15)
                                            Text("\(study.currentMemberIds.count)/\(study.totalMemberCount)")
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
                    }
                    .padding(.leading)
                }
                */
                VStack(alignment: .leading) {
                    HStack {
                        Text("참여 예정 스터디")
                            .font(.system(size: 16))
                            .bold()
                        Spacer()
                    }
                    Divider()
                    .padding(.vertical, 5)
                    Text("참여할 스터디가 없습니다.")
                }
                .padding(.top, 11)
                .padding(.horizontal)
                .foregroundColor(.black)
                Rectangle()
                    .fill(Color("DefaultGray"))
                VStack(alignment: .leading) {
                    HStack {
                        Text("참여 완료 스터디")
                            .font(.system(size: 16))
                            .bold()
                        Spacer()
                    }
                    Divider()
                    .padding(.vertical, 5)
                    Text("아직 참여한 스터디가 없습니다.")
                }
                .padding(.top, 11)
                .padding(.horizontal)
                .foregroundColor(.black)
                Rectangle()
                    .fill(Color("DefaultGray"))
            }
        }
    }
}

struct MyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        let studyViewModel = StudyViewModel()
        
        MyStudyView(studyArray: studyViewModel.studyArray)
    }
}
