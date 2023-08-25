//
//  MyBookMarkView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct MyBookMarkView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("북마크한 스터디가 나올 예정입니다")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.backward")
        })
        
    }
}

struct MyBookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookMarkView()
    }
}
