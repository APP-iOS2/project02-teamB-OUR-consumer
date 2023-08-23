//
//  LoginView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI
import FacebookCore
import FacebookLogin

struct LoginView: View {
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            
            Spacer()
            
            Group{
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 110)
                    .padding(.bottom, 10)
                
                Text("OUR")
                    .font(.system(size: 25))
                    .fontWeight(.black)
                
                Text(": 우리들의 취업 / 스터디 플랫폼")
            }
            
            Spacer()
            
            Group {
                FacebookLoginButton()
                    .frame(width: 200, height: 40)
                
                NavigationLink {
                    LoginSecondView()
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
                
                NavigationLink {
                    LoginSecondView()
                } label: {
                    HStack {
                        Image("AppleLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                        Text("Apple 로그인")
                    }
                    .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 40)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
    }
}

struct FacebookLoginButton: UIViewRepresentable {
    func makeUIView(context: Context) -> FBLoginButton {
        return FBLoginButton()
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
        // You can perform additional updates or configurations here if needed
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
