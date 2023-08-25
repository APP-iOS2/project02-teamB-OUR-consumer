//
//  MyBoardView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct MyBoardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<5) { _ in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\n게시물\n")
                                .font(.system(size: 16))
                                .bold()
                            Spacer()
                        }
                    }
                    .padding(.top, 11)
                    .padding(.horizontal)
                    .foregroundColor(.black)
                    Rectangle()
                        .fill(Color("DefaultGray"))
                }
                
            }
        }
    }
}

struct MyBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MyBoardView()
    }
}
