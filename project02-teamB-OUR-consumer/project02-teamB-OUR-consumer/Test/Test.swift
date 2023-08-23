//
//  Test.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/23.
//

import SwiftUI

struct Test: View {
    var postStore: PostStore
    
    var body: some View {        
        Text(String(postStore.post[0].numberOfComment))
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test(postStore: PostStore())
    }
}
