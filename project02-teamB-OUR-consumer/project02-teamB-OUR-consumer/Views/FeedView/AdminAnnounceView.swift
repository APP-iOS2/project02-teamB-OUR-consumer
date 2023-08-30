//
//  AdminAnnounceView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/30.
//

import SwiftUI

struct AdminAnnounceView: View {
    @Binding var isAlertSheet: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                // category
                Section("공지") {
                    VStack(alignment: .leading) {
                        // title
                        Text("Title")
                        // context
                        Text("공지")
                        // date?
                        Text("날짜")
                    }
                }
                
                Section("점검") {
                    VStack(alignment: .leading) {
                        Text("1/2")
                        Text("정기점검")
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
                        Text("완료")
                    }
                }
            }
        }
    }
}

struct AdminAnnounceView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAnnounceView(isAlertSheet: .constant(true))
    }
}
