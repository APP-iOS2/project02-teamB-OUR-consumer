//
//  PostModifyView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이승준 on 2023/08/25.
//

import SwiftUI

struct PostModifyView: View {
    
    @Binding var isShowingPostModifySheet: Bool
    @Binding var isShowingModifyDetailView: Bool
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 30) {
                Button {
                    isShowingPostModifySheet = false
                    isShowingModifyDetailView.toggle()
                } label: {
                    Label("수정", systemImage: "square.and.pencil")
                        .foregroundColor(Color(hex: 0x090580))
                }
                
                Divider()
                Button {
                    //게시물 삭제 함수!!!
                    isShowingPostModifySheet = false
                } label: {
                    Label("삭제", systemImage: "trash")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .font(.title2)
        }
    }
}

struct PostModifyView_Previews: PreviewProvider {
    static var previews: some View {
        PostModifyView(isShowingPostModifySheet: .constant(false), isShowingModifyDetailView: .constant(false))
    }
}
