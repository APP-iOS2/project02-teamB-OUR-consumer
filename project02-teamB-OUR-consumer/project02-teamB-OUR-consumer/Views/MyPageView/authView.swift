//
//  authView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 봉주헌 on 2023/08/25.
//

import SwiftUI

struct authView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State var isEditingModalPresented: Bool = false
    @State private var showingPasswordChangeView = false
    
    var body: some View {
        VStack{
            Text("봉주헌 님")
                .font(.title2)
                .padding([.top, .bottom])
            Text("ipo5069@naver.com")
                .font(.caption)
            Form{
                Button(action: {
                    isEditingModalPresented = true
                }) {
                    Text("정보 수정하기")
                }
                .sheet(isPresented: $isEditingModalPresented) {
                    editProView()
                }
                Button(action: {
                    self.showingPasswordChangeView.toggle()
                }, label: {
                    Text("암호 수정하기")
                })
                .sheet(isPresented: $showingPasswordChangeView, content: {
                    PasswordChangeView()
                })
            }
        }
    }
}


struct authView_Previews: PreviewProvider {
    static var previews: some View {
        authView()
    }
}
