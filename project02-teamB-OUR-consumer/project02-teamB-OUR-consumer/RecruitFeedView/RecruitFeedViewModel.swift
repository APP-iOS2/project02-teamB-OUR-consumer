//
//  RecruitFeedViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/22.
//

import Foundation


//아직 모델은 고민중
struct RecruitFeedViewModel {

    var privacySetting: Bool
    var title: String
    var content: String
    //var location: 뭐로할까
    //var photo: Image 뭐로할까
    var dateWriting: Date
    
}

//전체범위 공개 enum 처리
enum PrivacySetting {
    
    case Public
    case Private
    
    // 각 case에 맞게 가격을 화면에 보여주기 위해
    var setting: String {
        switch self {
        case .Public:
            return "Public"
        case .Private:
            return "Private"
        }
    }
}
