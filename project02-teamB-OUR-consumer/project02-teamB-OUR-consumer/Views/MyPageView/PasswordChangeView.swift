//
//  PasswordChangeView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 봉주헌 on 2023/08/25.
//

import SwiftUI

struct PasswordChangeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var newPasswordAgain = ""
    
    var body: some View {
        VStack {
            SecureField("현재 비밀번호", text: $currentPassword)
                .padding()
                .frame(width: 280, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            
            SecureField("새로운 비밀번호", text: $newPassword)
                .padding()
                .frame(width: 280, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            
            SecureField("새로운 비밀번호 확인", text: $newPasswordAgain)
                .padding()
                .frame(width: 280, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            Section {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("저장")
                        .frame(width: 250, height: 10)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(mainColor)
                        .cornerRadius(10)
                })
            }
            .padding()
        }
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView()
    }
}
