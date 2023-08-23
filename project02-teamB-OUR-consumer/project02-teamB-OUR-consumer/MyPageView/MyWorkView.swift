//
//  MyWorkView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyWorkCellView: View {
    @Binding var isMyProfile: Bool
    var work: WorkExperience
    
    @Binding var isChangeItem: Bool

    var body: some View {
        HStack(alignment: .top) {
            Image(work.company.companyImage ?? "CompanyImageSample")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
                .padding(.trailing, 5)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(work.jobTitle)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    
                    Spacer()
                  
                    if isMyProfile {
                        NavigationLink {
                            MyWorkEditView(isChangeItem: $isChangeItem)
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        }
                    }
                    .onTapGesture {
                        isChangeItem = true
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
    @ObservedObject var resumeStore: ResumeStore = ResumeStore()
    @Binding var isMyProfile: Bool
    
    @State var isChangeItem: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("경력")
                        .font(.system(size: 16))
                        .bold()
                    
                    Spacer()
                    
                    if isMyProfile {
                        NavigationLink {
                            MyWorkEditView(isChangeItem: $isChangeItem)
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                    .onTapGesture {
                        isChangeItem = false
                    }
  
                }
                .padding(.vertical, 5)
            }
            .padding(.top, 11)
            .padding(.horizontal)
            .foregroundColor(.black)
            
            VStack {
                // 최대 3개 보이도록
                ForEach(0..<resumeStore.resume.workExperience.count, id: \.self) { index in
                    if index < 3 {
                        MyWorkCellView(isMyProfile: $isMyProfile, work: resumeStore.resume.workExperience[index], isChangeItem: $isChangeItem)

                            .padding(.vertical, 8)
                        Divider()
                    }
                }
                .padding(.horizontal)
                
                // 경력 3개 넘으면 더보기
                if resumeStore.resume.workExperience.count > 3 {
                    NavigationLink {
                        MyWorkMoreView(isMyProfile: $isMyProfile)
                    } label: {
                        Text("더보기")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                }
            }
        }
    }
}

struct MyWorkView_Previews: PreviewProvider {
    static var previews: some View {
        MyWorkView(isMyProfile: .constant(true))
    }
}
