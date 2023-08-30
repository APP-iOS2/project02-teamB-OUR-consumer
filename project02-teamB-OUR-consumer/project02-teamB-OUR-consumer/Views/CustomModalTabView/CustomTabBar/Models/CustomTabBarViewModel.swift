//
//  CustomTabBarViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by woojin Shin on 2023/08/29.
//

import Foundation


final class CustomTabBarViewModel: ObservableObject {
    @Published var reportCount: Int = 0
    
    let service = RecruitService()
    
    // 실제 연동시 주석제거
    let userID: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue ) ?? ""
    
    
    func getReportCount() {
        print("UID userID  =  \(userID)")
        service.fetchOneData(collection: .users, documentID: userID) { result in

            self.reportCount = result["reportCount"] as? Int ?? 0
            
        }
    }
    
    
}
