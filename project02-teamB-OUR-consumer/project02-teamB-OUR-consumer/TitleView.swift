//
//  TitleView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct TitleView: View {
    
    @State private var searchFeed: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image("OUR_Logo_02")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                
                Spacer()

            }
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("오늘의 피드를 검색해보세요.", text: $searchFeed, axis: .horizontal)
            }
            .frame(width: 360, height: 50, alignment: .center)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
