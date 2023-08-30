//
//  StudyMemberSheetView.swift
//  project02-teamB-OUR-consumer
//
//  Created by yuri rho on 2023/08/23.
//

import SwiftUI

struct StudyMemberSheetView: View {
    @Binding var isShowingStudyMemberSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(0...3, id:  \.self) { data in
                        Button {
                            print("")
                        } label: {
                            HStack {
                                AsyncImage(url: URL(string: "https://i.ibb.co/B3zSTgy/2023-08-23-9-52-35.png")) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(50)
                                } placeholder: {
                                    ProgressView()
                                }
                                Text("여성은")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("참석멤버")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingStudyMemberSheet = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct StudyMemberSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StudyMemberSheetView(isShowingStudyMemberSheet: .constant(true))
    }
}
