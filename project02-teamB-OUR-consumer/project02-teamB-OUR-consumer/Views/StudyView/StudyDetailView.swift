//
//  StudyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by yuri rho on 2023/08/22.
//

import SwiftUI
import CoreLocation

struct StudyDetailView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var studyViewModel: StudyViewModel
    var study: Study
    @State var studyDetail: StudyDetail = StudyDetail.defaultStudyDetail
    
    @State private var isShowingStudyMemberSheet: Bool = false
    @State var isShowingLocationSheet: Bool = false
    @State var isSavedBookmark: Bool = true
    
    // 현재 로그인된 유저아이디
    var loginId = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    Image("OUR_Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .overlay(alignment:.bottom) {
                            VStack(alignment: .center, spacing: 10) {
                                Text(studyDetail.creator.name)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(studyDetail.title)
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255), radius: 5)
                            .padding(.horizontal, 20)
                            .offset(y:30)
                        }
                    
                    VStack {
                        
                        VStack {
                            Spacer(minLength: 20)
                            Text(studyDetail.description)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.leading)
                                .lineSpacing(3)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "mappin.and.ellipse" )
                                    .frame(width: 20)
                                Text("위치 : \(studyDetail.locationName ?? "")")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                Button {
                                    isShowingLocationSheet = true
                                } label: {
                                    Text("위치보기")
                                        .font(.system(size: 9, weight: .semibold))
                                        .foregroundColor(.black)
                                        .padding(3)
                                        .border(Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255))
                                        .background(Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255))
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.vertical, 5)
                            
                            HStack {
                                Image(systemName: "person.3.fill" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                Text("인원 : 최대 \(studyDetail.totalMemberCount)명 (\(studyDetail.currentMembers.count)/\(studyDetail.totalMemberCount))")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                Button {
                                    isShowingStudyMemberSheet.toggle()
                                } label: {
                                    Text("멤버보기")
                                        .font(.system(size: 9, weight: .semibold))
                                        .foregroundColor(.black)
                                        .padding(3)
                                        .border(Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255))
                                        .background(Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255))
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.bottom, 5)
                            
                            HStack{
                                Image(systemName: "calendar" )
                                    .frame(width: 20)
                                Text(studyDetail.studyDate)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            .padding(.bottom, 10)
                            
                            HStack {
                                
                                if studyDetail.creator.id == loginId {
                                    Button {
                                        print("")
                                    } label: {
                                        Text("수정")
                                            .bold()
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(.white)
                                            .background(Color(red: 9 / 255, green: 5 / 255, blue: 128 / 255))
                                            .cornerRadius(5)
                                    }
                                    Button {
                                        print("")
                                    } label: {
                                        Text("삭제")
                                            .bold()
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(.black)
                                            .background(Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255))
                                            .cornerRadius(5)
                                    }
                                    
                                } else {
                                    Button {
                                        print("")
                                    } label: {
                                        Text("참석")
                                            .bold()
                                            .frame(width: 290, height: 40)
                                            .foregroundColor(.white)
                                            .background(Color(red: 9 / 255, green: 5 / 255, blue: 128 / 255))
                                            .cornerRadius(5)
                                    }
                                    Button {
                                        isSavedBookmark.toggle()
                                    } label: {
                                        Image(systemName: isSavedBookmark ? "bookmark.fill" : "bookmark")
                                            .font(.system(size: 30))
                                            .frame(width: 60, height: 40)
                                            .foregroundColor(Color(red: 251 / 255, green: 55 / 255, blue: 65 / 255))
                                    }
                                }
                            }
                        }
                    }
                    .padding(15)
                    
                    StudyReplyView(studyViewModel: studyViewModel, study: study)
                }
            }
        }
        .onAppear {
            studyViewModel.makeStudyDetail(study: study) { studyDetail in
                self.studyDetail = studyDetail
                print(self.studyDetail)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.backward")
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: studyDetail.title) {
                    Label("공유하기", systemImage: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(role: .destructive) {
                        //
                    } label: {
                        Label("신고하기", systemImage: "exclamationmark.shield")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .sheet(isPresented: $isShowingStudyMemberSheet) {
            StudyMemberSheetView(isShowingStudyMemberSheet: $isShowingStudyMemberSheet)
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isShowingLocationSheet) {
            LocationSheetView(isShowingLocationSheet: $isShowingLocationSheet, locationCoordinate: CLLocationCoordinate2D(latitude: 37.5718, longitude: 126.9769))
                .presentationDetents([.medium])
        }
    }
}

struct StudyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            StudyDetailView(studyViewModel: StudyViewModel(), study: Study(creatorId: "", title: "", description: "", studyDate: "", deadline: "", isOnline: false, currentMemberIds: [""], totalMemberCount: 0, createdAt: "23.08.28"))
        }
    }
    
}
