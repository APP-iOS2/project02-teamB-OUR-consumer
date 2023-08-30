//
//  MyIntroView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyIntroView: View {
    @ObservedObject var resumeViewModel: ResumeViewModel
    @Binding var isMyProfile: Bool
    var myIntro: String {
        resumeViewModel.resume?.introduction ?? ""
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("자기소개")
                    .font(.system(size: 16))
                    .bold()
                
                Spacer()
                
                if isMyProfile {
                    NavigationLink {
                        MyIntroEditView(resumeViewModel: resumeViewModel)
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
            .padding(.bottom, 5)
            
            if myIntro != "" {
                Text(myIntro)
                    .font(.system(size: 14))
            } else {
                Text("자기소개를 입력해주세요")
                    .font(.system(size: 14))
            }
        }
        .padding()
        .foregroundColor(.black)
    }
}

struct MyIntroView_Previews: PreviewProvider {
    static var previews: some View {
        MyIntroView(resumeViewModel: ResumeViewModel(), isMyProfile: .constant(true))
    }
}
