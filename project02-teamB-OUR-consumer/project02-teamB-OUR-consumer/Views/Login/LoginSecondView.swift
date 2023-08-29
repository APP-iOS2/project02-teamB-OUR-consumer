//
//  LoginSecondView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/22.
//

import SwiftUI

struct LoginSecondView: View {
    let viewModel: AuthViewModel
    @State private var nameField: String = ""
    @State private var emailField: String = ""
    
    @State private var isAgree1: Bool = false
    @State private var isAgree2: Bool = false
    @State private var navigate: Bool = false
    private var isVaildButton: Bool {
        if nameField.isEmpty || !isAgree1 || !isAgree2 {
            return false
        } else {
            return true
        }
    }
    
    @State private var isShowingAlert: Bool = false
    @State private var alertText: String = ""
    
    var body: some View {
        NavigationStack {
            Spacer()
            Group {
                HStack {
                    Image("OUR_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                    Text("OUR")
                        .font(.system(size: 25))
                        .fontWeight(.black)
                        .padding(.top, 10)
                    Text(": 우리들의 취업 / 스터디 플랫폼")
                        .padding(.top, 15)
                }
                .padding(.bottom, 40)
            }
            
            Group {
                VStack(alignment: .leading) {
                    Text("Name")
                        .fontWeight(.bold)
                        .padding(.leading, 50)
                    TextField("Name", text: $nameField, axis: .horizontal)
                        .frame(width: 360, height: 50, alignment: .center)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 0, leading: 50, bottom: 20, trailing: 50))
                    
                    Text("E-Mail")
                        .fontWeight(.bold)
                        .padding(.leading, 50)
                    TextField(viewModel.signUpData.email, text: $emailField, axis: .horizontal)
                        .frame(width: 360, height: 50, alignment: .center)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                        .disabled(true)
                }
            }
            
            Spacer()
            
            Group {
                HStack {
                    Button {
                        isAgree1.toggle()
                    } label: {
                        if isAgree1 == false {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 30))
                                .foregroundColor(Color(hex: 0x090580))
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color(hex: 0x090580))
                        }
                    }
                    Text("이용약관 동의 (필수)")
                    
                    Spacer()
                    
                    NavigationLink {
                        AgreeTermView()
                    } label: {
                        Text("본문보기")
                            .foregroundColor(.gray)
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 5, trailing: 20))
                
                HStack {
                    Button {
                        isAgree2.toggle()
                    } label: {
                        if isAgree2 == false {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 30))
                                .foregroundColor(Color(hex: 0x090580))
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color(hex: 0x090580))
                        }
                    }
                    Text("개인정보 수집 및 이용 동의 (필수)")
                    Spacer()
                    NavigationLink {
                        AgreeTermView()
                    } label: {
                        Text("본문보기")
                            .foregroundColor(.gray)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            }
            
            Spacer()
            
            Button {
                if nameField.isEmpty {
                    isShowingAlert = true
                    alertText = "이름을 입력하여주세요"
                } else if !isAgree1 || !isAgree2 {
                    isShowingAlert = true
                    alertText = "약관에 모두 동의해주세요"
                } else {
                    viewModel.signUp(name: nameField) {
                        navigate = true
                    }
                }
            } label: {
                Text("회원가입")
                    .fontWeight(.bold)
                    .frame(width: 360, height: 50)
                    .background(isVaildButton ? Color(hex: 0x090580) : Color.gray)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    .padding(.bottom, 50)
            }
            .navigationDestination(isPresented: $navigate) {
                ContentView()
            }
            Spacer()
        }
        .alert(isPresented: $isShowingAlert){
            Alert(title: Text("경고"),
                  message: Text(alertText),
                  dismissButton: .default(Text("OK")))
        }
//        .navigationBarBackButtonHidden()
    }
}

struct LoginSecondView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSecondView(viewModel: AuthViewModel())
    }
}
