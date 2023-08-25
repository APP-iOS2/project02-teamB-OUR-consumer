//
//  editProView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 봉주헌 on 2023/08/25.
//

import SwiftUI

struct editProView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var email: String = ""
    
    var body: some View {
        VStack{
            
            TextField("이름", text: $name)
                .padding()
                .frame(width: 280, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            TextField("이메일 ", text: $email)
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
                        .background(Color(hex: 0x193B8A))
                        .cornerRadius(10)
                })
                .padding()
            }
        }
    }
}

struct editProView_Previews: PreviewProvider {
    static var previews: some View {
        editProView()
    }
}
