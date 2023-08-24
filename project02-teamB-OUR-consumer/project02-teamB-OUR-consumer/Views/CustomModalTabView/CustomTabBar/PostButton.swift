//
//  PostButton.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct PostButton: View {
    @State var selectedIndex = 0
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 40)
                .foregroundColor(Color.white)
                .shadow(radius: 3)
                
            Image(systemName: "plus")
                .foregroundColor(selectedIndex == 2 ? Color(.black) : Color(.tertiaryLabel))
                .font(.largeTitle)
        }
    }
}

struct PostButton_Previews: PreviewProvider {
    static var previews: some View {
        PostButton()
    }
}
