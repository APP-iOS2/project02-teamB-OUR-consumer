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
                 authenticateUser(for: user, with: error) {
                     completion()
                 }
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
                     completion()
                     return
                 }

                 guard let user = result?.user,
                       let idToken = user.idToken?.tokenString,
                        let email = user.profile?.email else {
                     return
                 }

                 let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                accessToken: user.accessToken.tokenString)
                 let firebaseAuth = Auth.auth()
                 firebaseAuth.signIn(with: credential) { [unowned self] (result, error) in
                     if let error = error {
                         print(error.localizedDescription)
                     } else {
                         guard let result = result else { return }
                         self.isAlreadyUser(loginType: "google", userId: result.user.uid, email: email) {
                             completion()
                         }
                     }
                 }
             }
         }
     }
     
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?, completion: @escaping () -> Void) {
         if let error = error {
             print(error.localizedDescription)
             return
         }

         guard let accessToken = user?.accessToken.tokenString,
               let idToken = user?.idToken?.tokenString else {
             return
         }

         let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

         Auth.auth().signIn(with: credential) { [unowned self] (result, error) in
             if let error = error {
                 print(error.localizedDescription)
             } else {
                 guard let result = result else { return }
                 self.state = .signedIn
                 UserDefaults.standard.set("google", forKey: Keys.loginType.rawValue)
                 UserDefaults.standard.set(result.user.uid, forKey: Keys.userId.rawValue)
                 UserDefaults.standard.set(result.user.email, forKey: Keys.email.rawValue)
             }
             completion()
         }
     }
    
    // 자동로그인
    func autoLogin(completion: @escaping (Bool) -> Void) {
        guard let uid = UserDefaults.standard.value(forKey: Keys.userId.rawValue) else {
            completion(false)
            return
        }
        
        self.state = .signedIn
        completion(true)
    }
    
    
    // 회원가입
    func signUp(name: String, completion: @escaping () -> Void) {
        dbRef.collection("users").document(signUpData.userId)
            .setData([
                "name": name,
                "email": signUpData.email
            ])
        
        UserDefaults.standard.set("google", forKey: Keys.loginType.rawValue)
        UserDefaults.standard.set(signUpData.userId, forKey: Keys.userId.rawValue)
        UserDefaults.standard.set(signUpData.email, forKey: Keys.email.rawValue)
//        state = .signedIn
        completion()
    }
     
     // 로그아웃
     func signOut() {
         GIDSignIn.sharedInstance.signOut()
         UserDefaults.standard.removeObject(forKey: Keys.userId.rawValue)
         UserDefaults.standard.removeObject(forKey: Keys.email.rawValue)
         UserDefaults.standard.removeObject(forKey: Keys.loginType.rawValue)
         
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
