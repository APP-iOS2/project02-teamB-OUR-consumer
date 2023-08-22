//
//  LoginView.swift
//  project02-teamB-OUR-consumer
//
//  Created by Handoo Jeong on 2023/08/22.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            
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
                Button {
                    //
                } label: {
                    HStack {
                        Image("FacebookLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Facebook 로그인")
                    }
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 40)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
                Button {
                    //
                } label: {
                    HStack {
                        Text("Google 로그인")
                    }
                    .fontWeight(.medium)
                    .foregroundColor(.indigo)
                    .frame(width: 300, height: 40)
                    .background(Capsule().strokeBorder())
                    .cornerRadius(10)
                }
                
                Button {
                    //
                } label: {
                    HStack {
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
