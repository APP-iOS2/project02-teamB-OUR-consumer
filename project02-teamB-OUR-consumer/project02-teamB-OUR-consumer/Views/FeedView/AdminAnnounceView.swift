//
//  AdminAnnounceView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/30.
//

import SwiftUI

struct AdminAnnounceView: View {
    @Binding var isAlertSheet: Bool
    @StateObject private var announce: AnnouncementStore = AnnouncementStore()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(announce.announcementArr) { announce in
                    NavigationLink {
                        AdminAnnounceDetailView(announce: announce)
                    } label: {
                        Text("[\(announce.category)] \(announce.title)")
                    }

                }
            }
            .navigationTitle("공지사항")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isAlertSheet.toggle()
                    } label: {
                        Text("닫기")
                    }
                }
            }
            .onAppear {
                announce.fetch()
            }
            .refreshable {
                announce.fetch()
            }
        }
    }
}

struct AdminAnnounceView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAnnounceView(isAlertSheet: .constant(true))
    }
}
