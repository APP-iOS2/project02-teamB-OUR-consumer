//
//  MyWorkView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyWorkCellView: View {
    @Binding var isMyProfile: Bool
    @ObservedObject var resumeViewModel: ResumeViewModel

    var work: WorkExperience
    var index: Int

    var body: some View {
        HStack(alignment: .top) {
            Image(work.company.companyImage ?? "CompanyImageSample")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
                .padding(.trailing, 5)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("\(work.company.companyName) - \(work.jobTitle)")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    
                    Spacer()
                  
                    if isMyProfile {
                        NavigationLink {
                            MyWorkEditView(resumeViewModel: resumeViewModel, isEditing: true, index: index)
                            
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        }
                    }
                    
                }
                
                Text("\(work.startDateString) - \(work.endDateString)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text(work.description ?? "")
                    .font(.system(size: 14))
            }
        }
    }
}

struct MyWorkView: View {
    var myWorks: [WorkExperience] {
        resumeViewModel.resume?.workExperience ?? []
    }
    @Binding var isMyProfile: Bool
    
    @ObservedObject var resumeViewModel: ResumeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("경력")
                            .font(.system(size: 16))
                            .bold()
                        
                        Spacer()
                        
                        if isMyProfile {
                            NavigationLink {
                                MyWorkEditView(resumeViewModel: resumeViewModel, isEditing: false, index: 0)
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
                .padding(.top, 11)
                .padding(.horizontal)
                .foregroundColor(.black)
                
                VStack(alignment: .leading) {
                    VStack {
                        // 최대 3개 보이도록
                        ForEach(0..<myWorks.count, id: \.self) { index in
                            if index < 3 {
                                MyWorkCellView(isMyProfile: $isMyProfile, resumeViewModel: resumeViewModel, work: myWorks[index], index: index)

                                    .padding(.vertical, 8)
                                Divider()
                            }
                        }
                        .padding(.horizontal)
                        
                        // 경력 3개 넘으면 더보기
                        if myWorks.count > 3 {
                            NavigationLink {
                                MyWorkMoreView(myWorks: myWorks, isMyProfile: $isMyProfile, resumeViewModel: resumeViewModel)
                            } label: {
                                Text("더보기")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, 8)
                            
                            Divider()
                        }
                        
                        // 경력 없을 때
                        if myWorks.count == 0 {
                            Text("경력을 추가해주세요")
                                .font(.system(size: 14))
                                .padding([.leading, .bottom])
                        }
                    }
                }
            }
        }
    }
}

struct MyWorkView_Previews: PreviewProvider {
    static var previews: some View {
        MyWorkView(isMyProfile: .constant(true), resumeViewModel: ResumeViewModel())
    }
}
