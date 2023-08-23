//
//  FeedView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var postData: PostData = PostData()
    @ObservedObject var idData: IdData = IdData()
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        VStack {
            PostView(idData: idData, postData: postData, isShowingSheet: $isShowingSheet)
        }

    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
