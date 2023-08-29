//
//  SwjTemp.swift
//  project02-teamB-OUR-consumer
//
//  Created by woojin Shin on 2023/08/26.
//

import SwiftUI


struct RecruitServiceExample: View {
    
    @ObservedObject var model = FeedViewModelTemp()
    @State var selectID = ""   //공백을 줘야 DocumentID를 nil로 인식하지않고 에러를 내지않는다.
    @State var changedContent = ""
    @State var selectIndex: Int = -1
    @State var limitCount: Int = 2
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Text("Posts")
                    .font(.caption)
                Button {
                    model.removeData(documentID: "\(selectID)")
                } label: {
                    Text("Delete")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .border(.black)
                
                
                Button {
                    model.updateField(documentID: "\(selectID)", data: .init(creator: "백엔드팀", content: "\(changedContent)" ))
                    
                    
                } label: {
                    Text("UPDate")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .border(.black)
                
                
                Button {
                    model.addDocument(data: .init(creator: "WJ", content: "Test", location: "korean Seoul", privateSetting: true, reportCount: 0, postImagePath: ""))
                } label: {
                    Text("ADD")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .border(.black)
                
                
                Button {
                    selectID = "kuXiDi8JD2HzEqb9NHG7"
                    model.fetchOneData(documentID: "\(selectID)")
                    
                } label: {
                    Text("FetchOne")
                        .font(.system(size: 14))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .border(.black)
                
                Text("\(model.feedDics.count) 건")
                
            }
            
            HStack {
//                if let name = model.feedDic["content"] as? String {
//                    Text("\(name)")
//                }
                
                Text("\(model.feedTable.id ?? "")")
                
                Divider().frame(height: 10)
                    .foregroundColor(.black)
                    .tint(.black)
                
                TextField("content 입력", text: $changedContent)
                
                Button(action: {
                    if limitCount == 0 {
                        limitCount = 2
                        model.limit = 0
                    } else {
                        limitCount = 0
                        model.limit = 2
                    }
                    
                    Task {
                        model.fetchAll()
                    }
                    
                }, label: {
                    if limitCount == 0 {
                        Text("전체다 나오게")
                    } else {
                        Text("\(limitCount)개만 나오게")
                    }
                    
                })
                .padding(5)
                .border(.blue)
                
                Button("검색") {
                    model.whereContentData = changedContent
//                    Task {
                        model.fetchAll()
                        
//                    }
                }
                .foregroundColor(.black)
                .padding(5)
                .border(.black)
                
                
            }
            .padding(.horizontal, 20)
            
            
            ScrollView(.vertical) {
                LazyVStack( alignment: .leading ) {
                    ForEach(model.feedTables) { index in
//Struct 객체 타입
                        //index = FeedRecruitModelTemp
                        VStack( alignment: .leading ) {
                            Button {
                                selectID = index.id ?? ""
                                print("\(index.id ?? "")")

                            } label: {
                             
                                Text("컨텐츠: \(index.content ?? "")")

                            }
                            .foregroundColor(.black)
                            
                        }
                        
                        
// Dictionary 타입
//                        VStack( alignment: .leading ) {
//                            Button {
//                                selectIndex = index
//
//                                if let id = model.feedDics[index]["id"] as? String {
//                                    selectID = id
//                                    print("\(selectID)")
//                                }
//
//                            } label: {
//                                /* Dictionary 형식으로 받아와서 써야 런타임 에러의 위험이 없다. */
//                                HStack {
//                                    if let name = model.feedDics[index]["creator"] as? String {
//                                        Text("\(index + 1).  \(name)")
//                                    }
//                                    VStack( alignment: .leading ) {
//                                        if let name = model.feedDics[index]["content"] as? String {
//                                            Text("컨텐츠: \(name)")
//                                                .multilineTextAlignment(.leading)
//                                        }
//
//                                        if let name = model.feedDics[index]["location"] as? String {
//                                            Text("위치: \(name)")
//                                        }
//                                    }
//                                }
//                            }
//                            .foregroundColor(.black)
//                            .background( selectIndex == index ? .yellow : .white)
//                        }
                        
                        Divider().frame( height: 10 )
                    }
                }
                .padding()
            }
            .onAppear {
//                Task {
                    model.limit = 50
                    model.isWorking = true
                    model.fetchAll()
//                }
            }
            .refreshable {
                //addSnapShotListener를 사용할 수 없기 때문에 추가.
                model.fetchAll()
            }
            
        }
        
    }
    
    
}

struct RecruitServiceExample_Previews: PreviewProvider {
    static var previews: some View {
        RecruitServiceExample()
    }
}
