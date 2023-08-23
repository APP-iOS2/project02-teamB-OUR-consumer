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
import GoogleSignIn
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    enum SignState {
        case signedIn
        case signUp
        case signedOut
    }
    
    struct SignUp {
        var userId: String
        var name: String
        var email: String
        var loginType: String
        
        static var empty: SignUp {
            return SignUp(userId: "", name: "", email: "", loginType: "")
        }
    }
     
     // 초기에는 로그아웃한 상태로 시작
    let dbRef = Firestore.firestore()
     @Published var state: SignState = .signedOut
    @Published var signUpData: SignUp = SignUp.empty
    
    func isAlreadyUser(loginType: String, userId: String, email: String, completion: @escaping () -> Void) {
        dbRef.collection("users").document(userId)
            .getDocument() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    return
                } else {
//                    print(querySnapshot?.exists)
                    if let isUser = querySnapshot?.exists {
                        if !isUser {
                            self.state = .signUp
                            self.signUpData.loginType = loginType
                            self.signUpData.userId = userId
                            self.signUpData.email = email
                        } else {
                            self.state = .signedIn
                        }
                    }
                }
                completion()
        }
    }

    func signIn(completion: @escaping () -> Void) {
         // 이전에 로그인 했는지 검사
         // 이전에 로그인 했으면 그 기억을 복구하고, 없으면 로그인을 시도한다.
         if GIDSignIn.sharedInstance.hasPreviousSignIn() {
             GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                 // 복구하면서 user 정보를 받아온다.
                 state = .signedIn
                 authenticateUser(for: user, with: error)
             }
         } else {
             // google service info.plist에서 clientId 값을 가져온다.
             guard let clientID = FirebaseApp.app()?.options.clientID else {
                 return
             }
             
             // 구글로그인 configuration 객체를 만든다.
             let config = GIDConfiguration(clientID: clientID)
             GIDSignIn.sharedInstance.configuration = config
             
             // 로그인
             GIDSignIn.sharedInstance.signIn(withPresenting: self.getRootViewController()) { result, error in
                 guard error == nil else {
                     print(error?.localizedDescription)
                     return
                 }

                 guard let user = result?.user,
                       let idToken = user.idToken?.tokenString,
                       let userId = user.userID,
                        let email = user.profile?.email else {
                     return
                 }

                 let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                accessToken: user.accessToken.tokenString)
                 Auth.auth().signIn(with: credential) { result, error in
                     
                 }
                 self.isAlreadyUser(loginType: "google", userId: userId, email: email) {
                     completion()
                 }
             }
         }
     }
     
     private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
         if let error = error {
             print(error.localizedDescription)
             return
         }
         
         // user 객체로부터 idToken과 accessToken을 가져온다.
         guard let accessToken = user?.accessToken.tokenString,
               let idToken = user?.idToken?.tokenString else {
             return
         }
         
//         print(user?.profile?.email)
         
         let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
         
         Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
             if let error = error {
                 print(error.localizedDescription)
             } else {
                 self.state = .signedIn
             }
         }
     }
    
    func signUp(name: String) {
        dbRef.collection("users").document(signUpData.userId)
            .setData([
                "name": name,
                "email": signUpData.email
            ])
        
        UserDefaults.standard.set("google", forKey: Keys.loginType.rawValue)
        UserDefaults.standard.set(signUpData.userId, forKey: Keys.userId.rawValue)
        UserDefaults.standard.set(signUpData.email, forKey: Keys.email.rawValue)
        
//        state = .signedIn
    }
     
     // 로그아웃
     func signOut() {
         GIDSignIn.sharedInstance.signOut()
         
         do {
             try Auth.auth().signOut()
             
             state = .signedOut
         } catch {
             print(error.localizedDescription)
         }
     }
     
     func getRootViewController() -> UIViewController {
         guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
             return .init()
         }

         guard let root = screen.windows.first?.rootViewController else {
             return .init()
         }
         

         return root
     }
}
