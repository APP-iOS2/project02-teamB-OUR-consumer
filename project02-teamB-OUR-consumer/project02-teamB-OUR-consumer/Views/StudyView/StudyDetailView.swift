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
    
    @ObservedObject var studyViewModel: StudyViewModel
    var study: Study
    
    @State private var isShowingStudyMemberSheet: Bool = false
    @State var isShowingLocationSheet: Bool = false
    @Binding var isSavedBookmark: Bool
    
    // 스터디 크리에이터아이디와 비교할 유저아이디 유저정보에서 받아와야함
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
                                Text(study.creatorId)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(study.title)
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
                            Text(study.description)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.leading)
                                .lineSpacing(3)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "mappin" )
                                    .frame(width: 15)
                                Text("위치 : \(study.locationName ?? "")")
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
                                    .frame(width: 15)
                                Text("인원 : 최대 \(study.totalMemberCount)명 (\(study.currentMemberIds.count)/\(study.totalMemberCount))")
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
                                    .frame(width: 15)
                                Text(study.studyDate)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            .padding(.bottom, 10)
                            
                            HStack {
                                
                                if study.creatorId == loginId {
                                    Button {
                                        print("")
                                    } label: {
                                        Text("수정")
                                            .bold()
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(.white)
                                            .background(Color(red: 9 / 255, green: 5 / 255, blue: 128 / 255))
                                            .cornerRadius(20)
                                    }
                                    Button {
                                        print("")
                                    } label: {
                                        Text("삭제")
                                            .bold()
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(.black)
                                            .background(Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255))
                                            .cornerRadius(20)
                                    }
                                    
                                } else {
                                    Button {
                                        print("")
                                    } label: {
                                        Text("참석")
                                            .bold()
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(.white)
                                            .background(Color(red: 9 / 255, green: 5 / 255, blue: 128 / 255))
                                            .cornerRadius(20)
                                    }
                                    Button {
                                        isSavedBookmark.toggle()
                                    } label: {
                                        Label("북마크", systemImage: isSavedBookmark ? "bookmark.fill" : "bookmark")
                                            .bold()
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(Color(red: 251 / 255, green: 55 / 255, blue: 65 / 255))
                                            .cornerRadius(20)
                                            .overlay(RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color(red: 9 / 255, green: 5 / 255, blue: 128 / 255), lineWidth: 2)
                                                  )
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.backward")
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: study.title) {
                    Label("공유하기", systemImage: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("")
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
            StudyDetailView(studyViewModel: StudyViewModel(), study: Study(creatorId: "", title: "", description: "", studyDate: "", deadline: "", isOnline: false, currentMemberIds: [""], totalMemberCount: 0, createdAt: "23.08.28"), isSavedBookmark: .constant(false))
        }
    }
    
}
