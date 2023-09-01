//
//  FeedRecruitTextEditorView.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/29.
//

import SwiftUI

struct FeedRecruitTextEditorView: View {
    @Binding var content: String
    @State var placeholder: String = "내용을 입력해주세요."
    var body: some View {
        
        ZStack{
            TextEditor(text: $content)
                .frame(minHeight:350, maxHeight:350)
                .buttonBorderShape(.roundedRectangle)
                .border(Color.secondary)
            
            
            if content.isEmpty {
                Text(placeholder)
                    .foregroundColor(.secondary)
                    .position(x: 80, y: 20) //plaecholder 위치변경
                
            }
            
        }
    }
    
}
struct FeedRecruitTextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitTextEditorView(content: .constant(""))
    }
}
