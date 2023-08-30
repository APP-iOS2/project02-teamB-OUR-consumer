//
//  RecruitMainSheet.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct RecruitMainSheet: View {
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            HStack {
                
                Text("등록하기")
                    .font(.title2)
//                Spacer().frame(width: 240)
                Spacer()
                Button {
                    isShowingSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
              
            }
            .padding(.top, 40)
            .padding(.horizontal, 25)
          
            RecruitButton()
        }
       
    }
}

struct RecruitMainSheet_Previews: PreviewProvider {
    static var previews: some View {
        RecruitMainSheet(isShowingSheet: .constant(true))
    }
}
