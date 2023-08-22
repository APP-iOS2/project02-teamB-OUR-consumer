//
//  StudyDetailView.swift
//  project02-teamB-OUR-consumer
//
//  Created by yuri rho on 2023/08/22.
//

import SwiftUI

struct StudyDetailView: View {
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Spacer(minLength: 60)
                AsyncImage(url: URL(string: "https://imgnews.pstatic.net/image/076/2023/08/22/2023082301001627800208041_20230822162503835.jpg?type=w647")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    VStack(alignment: .center, spacing: 10) {
                        Text("여성은")
                            .font(.subheadline)
                        Text("iOS 개발자 면접 스터디 모집")
                            .font(.title2)
                            .bold()
                    }
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255), radius: 5)
                    .padding(.horizontal, 20)
                    
                    ScrollView(.vertical) {
                        VStack {
                            Text("9월 1일 ~ 9월 30일 매주 토 14:00 ~ 16:00")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 251 / 255, green: 55 / 255, blue: 65 / 255))
                            Spacer(minLength: 20)
                            Text("""
       안녕하세용?
       함께 ios 개발자 면접을 준비하실 분을 찾습니다!!
       같이 손흥민(31)을 향한 걱정은 '기우'였다.
       자신에게 놓인 '위기론'을 직접 해결했다.손흥민은 지난 20일(한국시간) 영국 런던의 토트넘 핫스퍼 스타디움에서 열린 맨체스터 유나이티드와의 '2023~2024시즌 잉글리시 프리미어리그(EPL)' 2라운드 홈 경기에서 풀타임을 뛰며 맹활약했다.
       이날 토트넘은 파페 사르와 벤 데이비스의 연속골로 난적 맨유를 2-0으로 꺾었다.
       경기 후 손흥민을 향한 찬사가 쏟아졌다.
       영국 '90MIN'은 "오랜 시간 스포츠 탈장으로 고생한 손흥민이 회복 후 다른 모습을 보였다. 이전보다
       """)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(3)
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 5)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "mappin")
                                Text("위치 : 종각역 할리스")
                                    .bold()
                            }
                            HStack {
                                Image(systemName: "person.2.fill")
                                Text("인원 : 최대 5명 (1/5)")
                                    .bold()
                            }
                            HStack {
                                Image(systemName: "calendar")
                                Text("매주 토요일 14:00 ~ 16:00 9월 1일 ~ 9월 30일")
                                    .bold()
                            }
                            
                            HStack {
                                Button {
                                    print("")
                                } label: {
                                    Text("참석")
                                        .bold()
                                        .frame(width: 180, height: 40)
                                        .foregroundColor(.white)
                                        .background(Color(red: 9 / 255, green: 5 / 255, blue: 128 / 255))
                                        .cornerRadius(25)
                                }
                                Button {
                                    print("")
                                } label: {
                                    Text("공유")
                                        .bold()
                                        .frame(width: 180, height: 40)
                                        .foregroundColor(.black)
                                        .background(Color(red: 215 / 255, green: 215 / 255, blue: 215 / 255))
                                        .cornerRadius(25)
                                }
                            }
                            .padding(.top, 5)
                        }
                        .padding(15)
                        
                        Divider()
                    }
                }
                .offset(CGSize(width: 0, height: 150))
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("")
                    } label: {
                        Image(systemName: "bookmark")
                            .foregroundColor(Color(red: 251 / 255, green: 55 / 255, blue: 65 / 255))
                    }
                    
                }
            })
        }
        .padding(.top, 10)
    }
}

struct StudyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudyDetailView()
    }
}
