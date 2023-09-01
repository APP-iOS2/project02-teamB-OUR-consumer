//
//  LoginView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = AuthViewModel()
    @State var isLoading: Bool = false
    @State var navigate: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ActivityIndicator()
            }
            VStack {
                Spacer()
                
                Group{
                    // 1번안
                    Image("OUR_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 110)
                        .padding(.bottom, 10)
                    
                    // 2번안
                    Text("우리들의 취업 / 스터디 플랫폼")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Group {
//                    NavigationLink {
//                        //                        LoginSecondView()
//                    } label: {
//                        HStack {
//                            Image("FacebookLogo")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                            Text("Facebook 로그인")
//                        }
//                        .fontWeight(.medium)
//                        .foregroundColor(.white)
//                        .frame(width: 300, height: 40)
//                        .background(Color(hex: 0x006FFF))
//                        .cornerRadius(10)
//                    }.disabled(true)
                    Button {
                        isLoading = true
//                        viewModel.signOut()
                        viewModel.signIn() {
                            if viewModel.state != .signedOut {
                                navigate = true
                            }
                            isLoading = false
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 40)
                                .foregroundColor(Color(hex: 0x090580))
                                .cornerRadius(10)
                            HStack(alignment: .center) {
                                Image("GoogleLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25)
                                Text("Google 로그인")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(hex: 0x090580))
                            }
                            .frame(width: 297, height: 37)
                            .background(Color.white)
                            .cornerRadius(8)
                        }
                    }              
                    Spacer()
                    
                }.onAppear(perform: {
                    viewModel.autoLogin() { isLogin in
                        if isLogin {
                            navigate = true
                        }
                    }
                })
            }.navigationDestination(isPresented: $navigate) {
                if viewModel.state == .signUp {
                    LoginSecondView(viewModel: viewModel)
                } else {
                    CustomTabBarView()
                }
            }
        }
    }
}

struct ActivityIndicator: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(2)
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
