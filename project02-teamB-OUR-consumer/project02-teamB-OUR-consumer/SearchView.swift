//
//  SearchView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/22.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            Text("Search For \(searchText)")
        }
        .searchable(text: $searchText, prompt: "검색어를 입력해주세요.")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
