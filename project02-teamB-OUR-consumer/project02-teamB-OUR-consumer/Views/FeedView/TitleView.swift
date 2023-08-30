//
//  TitleView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct TitleView: View {
    
    @State private var searchFeed: String = ""
    @State var isAnimation: Bool = false
    @State private var name = ""
    @State private var isEditingName = false
    @State var searchCategory: [String] = ["게시글", "스터디", "사용자"]
    @State var selectedCategory: String = "게시글"
    @State var isFocus: Bool = false
    @State private var isAlertSheet: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Image("OUR_Logo_02")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                Spacer()
                Button {
                    isAlertSheet.toggle()
                } label: {
                    Image(systemName: "megaphone")
                        .font(.system(size: 25))
                        .foregroundColor(Color(hex: 0x090580))
                        .padding(.trailing, 25)
                }
                .sheet(isPresented: $isAlertSheet) {
                    AdminAnnounceView(isAlertSheet: $isAlertSheet)
                }
            }
            ZStack {
                Rectangle()
                    .foregroundColor(isAnimation ? Color.gray.opacity(0.3) : Color.gray.opacity(0.2))
                    .frame(width: 370, height: isAnimation ? 100 : 50)
                    .cornerRadius(20)
                    .offset(y: isAnimation ? 0 : -25)
                    .animation(.spring(response: 0.5, blendDuration: 1))
                    .padding(.top, 150)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .padding(.leading, 30)
                    
                    TextField("오늘의 \(selectedCategory)를 검색해보세요.", text: $searchFeed, onEditingChanged: { editing in
                        isFocus = editing
                        if editing {
                            isAnimation = true
                        } else {
                            isAnimation = false
                        }
                    })
                    .overlay (
                        Text("")
                            .padding(.leading, -100)
                            .foregroundColor(.black)
                    )
                    Button {
                        UIApplication.shared.endEditing()
                        
                    } label: {
                        Text("확인")
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            Picker("Food Category", selection: $selectedCategory) {
                ForEach(searchCategory, id: \.self) { category in
                    Text(category)
                }
            }
            .opacity(isAnimation ? 1.0 : 0.0)
            .animation(.easeIn(duration: 0.5))
            .frame(width: 350)
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 200)
            Spacer()
        }
    }
}

func isFocusSign(isFocus: Bool) -> String {
    return isFocus ? "O" : "X"
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
