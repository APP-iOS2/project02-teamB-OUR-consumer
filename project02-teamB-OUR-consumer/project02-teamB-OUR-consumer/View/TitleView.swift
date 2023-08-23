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
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                Text("OUR")
                    .font(.system(size: 25))
                    .fontWeight(.black)
                    .padding(EdgeInsets(top: 22, leading: 0, bottom: 0, trailing: 0))
                
                Spacer()
                
                Button {
                    //
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
                        .tint(.black)
                }
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
