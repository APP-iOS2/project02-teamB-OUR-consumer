//
//  AdminAnnounceDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/30.
//

import SwiftUI

struct AdminAnnounceDetailView: View {
    
    var announce: Announcement
    
    var body: some View {
//        Form {
//            Section {
//                Text("[\(announce.category)] \(announce.title)")
//                Text("\(announce.createdDate)")
//            }
//            Section {
//                Text("\(announce.context)")
//            }
//        }
        ScrollView {
            HStack(alignment: .lastTextBaseline) {
                VStack(alignment: .leading) {
                    Text("[\(announce.category)] \(announce.title)")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Text("\(announce.createdDate)")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20))
            
            Divider()
            
            HStack {
                Text("\(announce.context)")
                    .font(.system(size: 20))
                Spacer()
            }
            .padding()
            
        }
    }
}

struct AdminAnnounceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAnnounceDetailView(announce: Announcement.sample)
    }
}
