//
//  StudyMemberSheetView.swift
//  project02-teamB-OUR-consumer
//
//  Created by yuri rho on 2023/08/23.
//

import SwiftUI

struct StudyMemberSheetView: View {
    
    @Binding var isShowingStudyMemberSheet: Bool
    var viewModel: StudyViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.studyDetail.currentMembers.isEmpty {
                    Text("참석 멤버가 없습니다")
                } else {
                    List {
                        ForEach(viewModel.studyDetail.currentMembers) { data in
                            Button {
                                //MARK: 유저 프로필로 이동
                            } label: {
                                HStack {
                                    if data.profileImage != nil {
                                        AsyncImage(url: URL(string: data.profileImage!)) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .cornerRadius(50)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    } else {
                                        Image("OUR_Logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(50)
                                    }
                                    Text(data.name)
                                        .font(.system(size: 14, weight: .semibold))
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
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
        StudyMemberSheetView(isShowingStudyMemberSheet: .constant(true), viewModel: StudyViewModel())
    }
}
