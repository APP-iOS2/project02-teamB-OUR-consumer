//
//  AuthViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by woojin Shin on 2023/08/22.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FacebookCore
import FirebaseFirestore
import FBSDKLoginKit


class AuthViewModel: ObservableObject {
    
//    func signInFacebook() {
//        // 2-1. 필수 구현 부분 (필요 시, permissions을 더 추가할 수 있음)
//        LoginManager().logIn(permissions: ["public_profile","email"], from: nil) { result, error in
//            // 로그인 버튼 눌렀을 때 수행할 코드 여기에 작성 (아래 코드 자유롭게 수정!)
//            if let error = error {
//                // 로그인 창이 뜨지 않는 등 에러가 발생한 경우
//                print("Encountered Error: \(error)")
//            } else if let result = result, result.isCancelled {
//                // 로그인 창이 떴지만, 사용자가 취소를 한 경우
//                print("Cancelled")
//            } else {
//                // 로그인 창이 뜨고, 사용자가 로그인에 성공한 경우
//                print("Logged In")
//            }
//        }
//    }
    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//      if let error = error {
//        print(error.localizedDescription)
//        return
//      }
//      // ...
//    }
}
