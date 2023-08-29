//
//  MyFollowerCell.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct MyFollowerCell: View {
    var body: some View {
        HStack(spacing: 8) {
            Image("OUR_Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(50)
            
            Text("ID")
                
            Spacer()
            
            Button {
                
            } label: {
                
            }
        }
    }
}

struct MyFollowerCell_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowerCell()
    }
}
