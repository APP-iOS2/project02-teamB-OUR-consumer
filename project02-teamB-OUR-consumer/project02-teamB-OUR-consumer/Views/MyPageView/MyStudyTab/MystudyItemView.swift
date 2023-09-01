//
//  MystudyItemView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 봉주헌 on 2023/09/01.
//

import SwiftUI

struct MystudyItemView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @ObservedObject var studyViewModel: StudyViewModel = StudyViewModel()
    
    var study: StudyDTO
    var body: some View {
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
                //                AsyncImage(url: study.imageString[0]) { image in
                //                    image
                //                        .resizable()
                //                        .aspectRatio(contentMode: .fill)
                //                        .frame(width: 130, height: 130)
                //                        .cornerRadius(10)
                //                } placeholder: {
                //                    ProgressView()
                //                }
                //                VStack(alignment: .leading) {
                //                    Text("\(study.title)")
                //                        .frame(width: 130, height: 50)
                //                        .bold()
                //                }
                //                .fixedSize(horizontal: false, vertical: true)
                //                .frame(width: 100)
                AsyncImage(url: URL(string: study.imageString?[0] ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                } placeholder: {
                    Image("OUR_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
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
                    StudyDetailView(viewModel: StudyViewModel(), study: StudyDTO.defaultStudy, isSavedBookmark: false)
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

struct MystudyItemView_Previews: PreviewProvider {
    static var previews: some View {
        MystudyItemView(study: StudyDTO.defaultStudy)
            .environmentObject(UserViewModel())
    }
}
