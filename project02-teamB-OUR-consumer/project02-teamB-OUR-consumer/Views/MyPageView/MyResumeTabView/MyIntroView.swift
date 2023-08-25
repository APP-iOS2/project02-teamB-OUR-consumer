//
//  MyIntroView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyIntroView: View {
    var myIntro: String?
    @Binding var isMyProfile: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("자기소개")
                    .font(.system(size: 16))
                    .bold()
                
                Spacer()
                
                if isMyProfile {
                    NavigationLink {
                        MyIntroEditView()
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
            .padding(.vertical, 5)
            
            Text(myIntro ?? "자기소개를 입력하세요")
                .font(.system(size: 14))
        }
        .padding()
        .foregroundColor(.black)
    }
//    func changeToggle(_ toggle: Bool) {
//
//    }
}

struct MyIntroView_Previews: PreviewProvider {
    static var previews: some View {
        MyIntroView(isMyProfile: .constant(true))
    }
}
