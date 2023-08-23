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
                    Button {
                        print("")
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: "https://i.ibb.co/phFSp0s/2023-08-23-9-52-55.png")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(50)
                            } placeholder: {
                                ProgressView()
                            }
                            Text("선아라")
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
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
                            Text("안지영")
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
                    Button {
                        print("")
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: "https://i.ibb.co/K2SMzgt/2023-08-23-10-26-57.png")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(50)
                            } placeholder: {
                                ProgressView()
                            }
                            Text("전민석")
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
                    Button {
                        print("")
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: "https://i.ibb.co/dfRykhp/2023-08-23-9-53-23.png")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(50)
                            } placeholder: {
                                ProgressView()
                            }
                            Text("노유리")
                                .font(.system(size: 14, weight: .semibold))
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
