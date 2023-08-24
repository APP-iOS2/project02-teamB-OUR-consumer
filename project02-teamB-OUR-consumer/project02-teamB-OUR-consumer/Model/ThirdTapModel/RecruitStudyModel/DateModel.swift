//
//  Date.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import Foundation
import SwiftUI
import Foundation

struct DateModel: Identifiable {
    var id: String = UUID().uuidString
    var startDate: Date
    var endDate: Date
    //날짜를 변환하기 위한 formatter를 설정 해준다
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        return formatter
    }()
    //startDate를 string타입으로 변환한다
    var formattedStartDate: String {
        return DateModel.dateFormatter.string(from: startDate)
    }
    
    var formattedEndDate: String {
        return DateModel.dateFormatter.string(from: endDate)
    }
}
