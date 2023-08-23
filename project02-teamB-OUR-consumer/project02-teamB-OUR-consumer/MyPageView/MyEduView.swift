//
//  MyEduView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyEduCellView: View {
    var education: Education
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("\(education.schoolName) - \(education.fieldOfStudy)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    // 교육 편집
                } label: {
                    Image(systemName: "pencil")
                        .foregroundColor(.black)
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
    @ObservedObject var resumeStore: ResumeStore = ResumeStore()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("교육")
                        .font(.system(size: 16))
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink {
                        // 교육 추가
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .padding(.vertical, 5)
            }
            .padding(.top, 11)
            .padding(.horizontal)
            .foregroundColor(.black)
            VStack {
                // 최대 3개 보이도록
                ForEach(0..<resumeStore.resume.education.count, id: \.self) { index in
                    if index < 3 {
                        MyEduCellView(education: resumeStore.resume.education[index])
                            .padding(.vertical, 8)
                        Divider()
                    }
                }
                .padding(.horizontal)
                
                // 교육 3개 넘으면 더보기
                if resumeStore.resume.education.count > 3 {
                    NavigationLink {
                        // 교육 더보기
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

struct MyEduView_Previews: PreviewProvider {
    static var previews: some View {
        MyEduView()
    }
}
