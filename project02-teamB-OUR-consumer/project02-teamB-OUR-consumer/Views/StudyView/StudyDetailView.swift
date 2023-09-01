//
//  StudyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by yuri rho on 2023/08/22.
//

import SwiftUI
import CoreLocation

enum StudyDetailAlert {
    case delete
    case normal
    case commentDelete
}

struct StudyDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var viewModel: StudyViewModel
    var study: StudyDTO
    
    @State private var isShowingStudyMemberSheet: Bool = false
    @State var isShowingLocationSheet: Bool = false
    @State var isShowingReportSheet: Bool = false
    @State var isSavedBookmark: Bool
    @State var showAlert: Bool = false
    @State var alertText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    if viewModel.studyDetail.imageString?.isEmpty == false {
                        AsyncImage(url: URL(string: viewModel.studyDetail.imageString?[0] ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                        } placeholder: {
                            Image("our_placeholder")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        }
                        .frame(maxWidth: .infinity)
                        .overlay(alignment:.bottom) {
                            VStack(alignment: .center, spacing: 10) {
                                Text(viewModel.studyDetail.creator.name)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(viewModel.studyDetail.title)
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
                    } else {
                        Image("OUR_Logo")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .overlay(alignment:.bottom) {
                                VStack(alignment: .center, spacing: 10) {
                                    Text(viewModel.studyDetail.creator.name)
                                        .font(.system(size: 14, weight: .semibold))
                                    Text(viewModel.studyDetail.title)
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
                    }
                    
                    VStack {
                        VStack {
                            //TODO: 텍스트가 가로로 꽉 차게 나왔으면 좋겠다.
                            Spacer(minLength: 20)
                            Text(viewModel.studyDetail.description)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.leading)
                                .lineSpacing(3)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: viewModel.studyDetail.isOnline ? "macbook.and.iphone" : "mappin.and.ellipse" )
                                    .frame(width: 20)
                                Text(viewModel.studyDetail.isOnline ? "링크 추후 안내" : "\(viewModel.studyDetail.locationName ?? "위치정보없음")")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                if !viewModel.studyDetail.isOnline {
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
                            }
                            .padding(.vertical, 5)
                            
                            HStack {
                                Image(systemName: "person.3.fill" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                Text("최대 \(viewModel.studyDetail.totalMemberCount)명 (\(viewModel.studyDetail.currentMembers.count)/\(viewModel.studyDetail.totalMemberCount))")
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
                                Text(viewModel.studyDetail.studyDate)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            .padding(.bottom, 10)
                            
                            HStack {
                                //MARK: 1 - 내가 작성한 글
                                if isMyStudy()  {
//                                    NavigationLink {
//                                        //TODO: 수정페이지로 이동
//                                        StudyDetailEditView(viewModel: viewModel, study: study)
//                                    }
                                    Button {
                                        alertText = "할거에여.."
                                        viewModel.alertCase = .normal
                                        showAlert = true
                                    } label: {
                                        Text("수정")
                                            .bold()
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(.white)
                                            .background(Color(red: 9 / 255, green: 5 / 255, blue: 128 / 255))
                                            .cornerRadius(5)
                                    }
                                    Button {
                                        if viewModel.studyDetail.currentMembers.count >= 2 {
                                            alertText = "참석자가 있는 스터디는 삭제할 수 없습니다."
                                            viewModel.alertCase = .normal
                                            showAlert = true
                                        } else {
                                            viewModel.alertCase = .delete
                                            showAlert = true
                                        }
                                    } label: {
                                        Text("삭제")
                                            .bold()
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(.black)
                                            .background(Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255))
                                            .cornerRadius(5)
                                    }
                                } else {
                                    if viewModel.studyDetail.isJoined {
                                        //MARK: 2 - 이미 참석한 스터디
                                        Button(action: {
                                            //TODO: 참석 취소를 할까말까
                                        }, label: {
                                            Text("이미 참석한 스터디입니다.")
                                                .bold()
                                                .frame(width: 290, height: 40)
                                                .foregroundColor(.white)
                                                .background(.gray)
                                                .cornerRadius(5)
                                        }).disabled(true)
                                    } else if viewModel.studyDetail.currentMembers.count == viewModel.studyDetail.totalMemberCount {
                                        //MARK: 3 - 인원이 다 찼을 때 모집마감
                                        Button(action: {
                                        }, label: {
                                            Text("모집 마감된 스터디입니다.")
                                                .bold()
                                                .frame(width: 290, height: 40)
                                                .foregroundColor(.white)
                                                .background(.gray)
                                                .cornerRadius(5)
                                        }).disabled(true)
                                    } else {
                                        //MARK: 4 - 아무 케이스도 해당x
                                        Button {
                                            Task {
                                                await viewModel.joinStudy()
                                                alertText = "스터디에 참여하였습니다."
                                                viewModel.alertCase = .normal
                                                showAlert = true
                                            }
                                        } label: {
                                            Text("참석")
                                                .bold()
                                                .frame(width: 290, height: 40)
                                                .foregroundColor(.white)
                                                .background(Color(red: 9 / 255, green: 5 / 255, blue: 128 / 255))
                                                .cornerRadius(5)
                                        }
                                    }
                                    Button {
                                        isSavedBookmark.toggle()
                                        if isSavedBookmark {
                                            viewModel.updateBookmark(studyID: viewModel.studyDetail.id)
                                        } else {
                                            viewModel.removeBookmark(studyID: viewModel.studyDetail.id)
                                        }
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
                    
                    StudyReplyView(viewModel: viewModel ,showAlert: $showAlert)
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
                ShareLink(item: viewModel.studyDetail.title) {
                    Label("공유하기", systemImage: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        if isAlreadyReported() {
                            alertText = "이미 신고한 스터디입니다."
                            viewModel.alertCase = .normal
                            showAlert = true
                        } else {
                            isShowingReportSheet = true
                        }
                    }, label: {
                        Label("신고하기", systemImage: "exclamationmark.shield")
                    })
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .sheet(isPresented: $isShowingStudyMemberSheet) {
            StudyMemberSheetView(isShowingStudyMemberSheet: $isShowingStudyMemberSheet, viewModel: viewModel)
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isShowingLocationSheet) {
            LocationSheetView(viewModel: viewModel, locationCoordinate: CLLocationCoordinate2D(latitude: viewModel.studyDetail.locationCoordinate?[0] ?? 0.0, longitude: viewModel.studyDetail.locationCoordinate?[1] ?? 0.0), isShowingLocationSheet: $isShowingLocationSheet)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isShowingReportSheet) {
            StudyReportView(viewModel: viewModel, isStudy: true)
        }
        .alert(isPresented: $showAlert, content: {
            if viewModel.alertCase == .normal {
                return Alert(title: Text("알림"),
                             message: Text(alertText),
                             dismissButton: .destructive(Text("확인")) {
                })
            } else if viewModel.alertCase == .delete {
                return Alert(title: Text("게시물을 삭제하겠습니까?"),
                             message: Text("게시물을 삭제합니다"),
                             primaryButton: .destructive(Text("삭제")) {
                    viewModel.deleteStudy(studyID: viewModel.studyDetail.id)
                    dismiss()
                }, secondaryButton: .cancel(Text("취소")))
            } else {
                return Alert(title: Text("댓글을 삭제하겠습니까?"),
                             message: Text("댓글을 삭제합니다"),
                             primaryButton: .destructive(Text("삭제")) {
                    Task {
                        await self.viewModel.deleteComment()
                    }
                }, secondaryButton: .cancel(Text("취소")))
            }
        })
        .onAppear(){
            Task {
                await viewModel.makeStudyDetail(study: study)
            }
        }
    }
    
    func isMyStudy() -> Bool {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return false
        }
        // 작성자 id와 내 id가 같다면
        if viewModel.studyDetail.creator.id == userId {
            return true
        } else {
            return false
        }
    }
    
    func isAlreadyReported() -> Bool {
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return false
        }
        if viewModel.studyDetail.reportUserIds.contains(userId) {
            return true
        }
        return false
    }
}

struct StudyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            StudyDetailView(viewModel: StudyViewModel(), study: StudyDTO.defaultStudy, isSavedBookmark: false)
        }
    }
    
}
