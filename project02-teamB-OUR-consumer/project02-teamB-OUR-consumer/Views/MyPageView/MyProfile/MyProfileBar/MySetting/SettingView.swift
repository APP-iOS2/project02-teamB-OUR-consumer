//
//  SettingView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI
import FirebaseAuth

// settingView 는 userDefaults 로 처리?

struct SettingView: View {
    @State var notificationsEnabled: Bool = false
    @State var privacySetting: Bool = false // 스프레드 시트 보기
    @State var isLogoutAlert: Bool = false
    
    @State var isLoggedIn: Bool = true
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Divider()
                    .padding(.top, 0)
                VStack(alignment: .leading) {
                    Group {
                        Text("계정 설정")
                            .font(.headline)
                            .padding(.bottom)
                        HStack {
                            Text("로그인된 계정")
                            
                            Spacer()
                            Text("lion@gmail.com")
                        }
                        .padding(.vertical, 5)
                        Divider()
                    }
                    
                    Group {
                        HStack {
                            Button {
                                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                                }
                            } label: {
                                Text("알림 설정")
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                        .padding(.vertical)
                        Divider()
                    }
                    
                    Group {
                        NavigationLink {
                            InquiryView()
                        } label: {
                            Text("1 대 1 문의")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding(.vertical)
                        Divider()
                    }
                    
                    Group {
                        Button {
                            // 로그아웃
                            isLogoutAlert = true
                        } label: {
                            Text("로그아웃")
                                .font(.headline)
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical)
                        Divider()
                    }
                }
                .padding()
            }
            .alert(isPresented: $isLogoutAlert) {
                Alert(title: Text("로그아웃 하시겠습니까?"), primaryButton: .destructive(Text("확인"), action: {
                    logoutAction()
                }), secondaryButton: .cancel(Text("취소")))
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.backward")
            })
        }
        .background(
            NavigationLink(destination: LoginView(), isActive: $isLoggedIn, label: {
                Text("")
                    .hidden()
            })
        )
    }
    
    private func logoutAction() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            NavigationUtil.popToRootView()
        } catch {
            print("-----로그아웃에 실패하였습니다-----")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct NavigationUtil {
  static func popToRootView() {
      let keyWindow = UIApplication.shared.connectedScenes
              .filter({$0.activationState == .foregroundActive})
              .compactMap({$0 as? UIWindowScene})
              .first?.windows
              .filter({$0.isKeyWindow}).first
    findNavigationController(viewController: keyWindow?.rootViewController)?
      .popToRootViewController(animated: true)
  }
 
  static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
    guard let viewController = viewController else {
      return nil
    }
 
    if let navigationController = viewController as? UINavigationController {
      return navigationController
    }
 
    for childViewController in viewController.children {
      return findNavigationController(viewController: childViewController)
    }
 
    return nil
  }
}
