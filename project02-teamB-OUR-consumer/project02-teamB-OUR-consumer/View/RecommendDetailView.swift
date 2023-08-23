//
//  RecommendDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/23.
//

import SwiftUI

struct RecommendDetailView: View {
    
    
    var body: some View {
        HStack {
            Image("Chan")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 40)
            VStack(alignment: .leading) {
                Text("이름")
                    .font(.system(size: 16))
                    .fontWeight(.heavy)
                Text("간단한 자기소개")
                    .font(.system(size: 14))
                    .fontWeight(.light)
            }
        }
    }
}

struct RecommendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendDetailView()
    }
}
