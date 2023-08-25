//
//  FeedTabView.swift
//  HomeTab
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct FeedTabView: View {
    
    @StateObject private var idData: IdData = IdData()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TitleView()
                    FeedView()
                }
            }
        }
    }
}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
    }
}
