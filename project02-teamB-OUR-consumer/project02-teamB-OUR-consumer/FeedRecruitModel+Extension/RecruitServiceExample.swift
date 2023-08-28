//
//  SwjTemp.swift
//  project02-teamB-OUR-consumer
//
//  Created by woojin Shin on 2023/08/26.
//

import SwiftUI


struct RecruitServiceExample: View {
    
    @ObservedObject var model = FeedViewModelTemp()
    @State var selectID = " "   //공백을 줘야 DocumentID를 nil로 인식하지않고 에러를 내지않는다.
    @State var changedContent = ""
    @State var selectIndex: Int = -1
    
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
                    model.updateField(documentID: "\(selectID)", data: .init(content: "\(changedContent)" , reportCount: 435))
                    
                } label: {
                    Text("UPDate")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .border(.black)
                
                
                Button {
                    model.addDocument(data: .init(creator: "ID업데이트", content: "테스트중", reportCount: 49))
                } label: {
                    Text("ADD")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .border(.black)
                
                
                Button {
                    selectID = "2N0ohAhpHgt1KbgU5AEY"
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
                if let name = model.feedDic["content"] as? String {
                    Text("\(name)")
                }
                Divider().frame(height: 10)
                    .foregroundColor(.black)
                    .tint(.black)
                
                TextField("content 입력", text: $changedContent)
                
                Button("2개만 나오게") {
                    model.limit = 2
                    Task {
                        await model.fetchAll()
                        
                    }
                }
                .padding(5)
                .border(.blue)
                
                Button("검색") {
                    model.whereContentData = changedContent
                    Task {
                        await model.fetchAll()
                        
                    }
                }
                .foregroundColor(.black)
                .padding(5)
                .border(.black)
                
                
            }
            .padding(.horizontal, 20)
            
            
            ScrollView(.vertical) {
                LazyVStack( alignment: .leading ) {
                    ForEach(model.feedDics.indices, id: \.self) { index in
//Struct 객체 타입
//                        VStack( alignment: .leading) {
//                            Button {
//                                print("\(index.id ?? "")")
//
//                            } label: {
//                                Text("\(index.creator ?? "")")//
//                                Text("컨텐츠: \(index.content ?? "")")
//
//                            }
//                            .foregroundColor(.black)
//                        }
                        
// Dictionary 타입
                        VStack( alignment: .leading ) {
                            Button {
                                selectIndex = index
                                
                                if let id = model.feedDics[index]["id"] as? String {
                                    selectID = id
                                    print("\(selectID)")
                                }

                            } label: {
                                /* Dictionary 형식으로 받아와서 써야 런타임 에러의 위험이 없다. */
                                HStack {
                                    if let name = model.feedDics[index]["creator"] as? String {
                                        Text("\(index + 1).  \(name)")
                                    }
                                    VStack( alignment: .leading ) {
                                        if let name = model.feedDics[index]["content"] as? String {
                                            Text("컨텐츠: \(name)")
                                        }
                                        if let name = model.feedDics[index]["location"] as? String {
                                            Text("위치: \(name)")
                                        }
                                    }
                                }
                            }
                            .foregroundColor(.black)
                            .background( selectIndex == index ? .yellow : .white)
                        }
                        
                        Divider().frame( height: 10 )
                    }
                }
                .padding()
            }
            .onAppear {
                Task {
                    model.limit = 50
                    await model.fetchAll()
                }
            }
            
        }
        
    }
    
    
}

struct RecruitServiceExample_Previews: PreviewProvider {
    static var previews: some View {
        RecruitServiceExample()
    }
}
