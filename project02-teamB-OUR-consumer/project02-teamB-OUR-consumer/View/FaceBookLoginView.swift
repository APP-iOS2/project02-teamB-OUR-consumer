//
//  FaceBookLoginView.swift
//  project02-teamB-OUR-consumer
//
//  Created by SONYOONHO on 2023/08/23.
//

import SwiftUI
import FBSDKLoginKit
import Firebase

struct FaceBookLoginView: UIViewRepresentable {
    
    func makeCoordinator() -> FaceBookLoginView.Coordinator {
        return FaceBookLoginView.Coordinator()
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if let error = error {
              print(error.localizedDescription)
              return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
              if let error = error {
                print(error.localizedDescription)
                return
              }
              print("Facebook Sign In")
            }
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<FaceBookLoginView>) -> FBLoginButton {
        let view = FBLoginButton()
        view.permissions = ["email"]
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FaceBookLoginView>) { }
}
