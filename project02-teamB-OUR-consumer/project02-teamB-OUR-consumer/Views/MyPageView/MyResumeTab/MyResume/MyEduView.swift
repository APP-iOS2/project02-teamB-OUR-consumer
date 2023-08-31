//
//  MyEduView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyEduCellView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    @Binding var isMyProfile: Bool
    var education: Education
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("\(education.schoolName) - \(education.fieldOfStudy)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Spacer()
                
                if isMyProfile {
                    NavigationLink {
                        MyEduEditView(resumeViewModel: resumeViewModel, isEditing: isMyProfile, index: index)
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.black)
                    }
                }
            }
            
            Text("2023.05 - 현재 | \(education.degree)")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            
            Text(education.description ?? "")
                .font(.system(size: 14))
        }
    }
}

struct MyEduView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    var myEdus: [Education] {
        resumeViewModel.resume?.education ?? []
    }
    @Binding var isMyProfile: Bool
    @State var isDeleteItemAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("교육")
                            .font(.system(size: 16))
                            .bold()
                        
                        Spacer()
                        
                        if isMyProfile {
                            NavigationLink {
                                MyEduEditView(resumeViewModel: resumeViewModel, isEditing: false, index: 0)
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
                        ForEach(0..<myEdus.count, id: \.self) { index in
                            if index < 3 {
                                MyEduCellView(resumeViewModel: resumeViewModel, isMyProfile: $isMyProfile, education: myEdus[index], index: index)
                                    .padding(.vertical, 8)
                                Divider()
                            }
                        }
                        .padding(.horizontal)
                        
                        // 교육 3개 넘으면 더보기
                        if myEdus.count > 3 {
                            NavigationLink {
                                MyEduMoreView(resumeViewModel: resumeViewModel, myEdu: myEdus, isMyProfile: $isMyProfile)
                            } label: {
                                Text("더보기")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, 8)
                            
                            Divider()
                        }
                        
                        // 교육 없을 때
                        if myEdus.count == 0 {
                            Text("교육을 추가해주세요")
                                .font(.system(size: 14))
                                .padding([.leading, .bottom])
                        }
                    }
                }
            }
        }
    }
}

struct MyEduView_Previews: PreviewProvider {
    static var previews: some View {
        MyEduView(resumeViewModel: ResumeViewModel(), isMyProfile: .constant(true))
    }
}
