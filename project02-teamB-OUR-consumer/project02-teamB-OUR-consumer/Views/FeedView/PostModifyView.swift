//
//  PostModifyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/25.
//

import SwiftUI

struct PostModifyView: View {
    @Binding var isShowingPostModifySheet: Bool
    var body: some View {
        
        VStack {
            Text("공사중")
            Button {
                //수정
            } label: {
                Label("수정", systemImage: "trash")
                    .foregroundColor(Color(hex: 0x090580))
            }
            
            Button {
                //삭제
            } label: {
                Label("삭제", systemImage: "trash")
                    .foregroundColor(.red)
            }
        }
        .font(.title)
        
    }
}

struct PostModifyView_Previews: PreviewProvider {
    static var previews: some View {
        PostModifyView(isShowingPostModifySheet: .constant(false))
    }
}
