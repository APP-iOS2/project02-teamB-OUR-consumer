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
        ScrollView(.horizontal, showsIndicators: false) {
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
                VStack(spacing: 20) {
                    if study.imageString?.isEmpty == false {
                        AsyncImage(url: URL(string: study.imageString?[0] ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(10)
                        } placeholder: {
                            Image("OUR_Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(10)
                        }
                    } else{
                        Image("OUR_Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 130)
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(study.title)
                            .frame(width: 130, height: 30)
                            .bold()
                        VStack(alignment: .leading, spacing: 5) {
                            Text(study.studyDate)
                            Label(study.isOnline ? "링크 추후 안내" : "\(study.locationName ?? "위치정보없음")", systemImage: study.isOnline ? "macbook.and.iphone" : "mappin.and.ellipse")
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
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 100)
                }
                .onAppear {
                    studyViewModel.fetchStudy()
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
