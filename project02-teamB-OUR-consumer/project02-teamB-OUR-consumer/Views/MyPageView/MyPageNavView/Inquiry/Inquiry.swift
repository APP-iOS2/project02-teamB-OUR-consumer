//
//  ChatModel.swift
//  project02-teamB-OUR-admin
//
//  Created by 신희권 on 2023/08/22.
//

import Foundation

struct Message : Identifiable, Codable {
    var id: UUID = UUID()
    let text: String
    let sender: String

    var createdAt: Double = Date().timeIntervalSince1970

    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "HH:mm"

        return dateFormatter.string(from: dateCreatedAt)
    }
    
}

extension Message {
    static let mockData:[Message] = [
      Message(text: "안돼", sender: "Admin"),
      Message(text: "뭐야 내 스터디 돌려줘요", sender: "User"),
      Message(text: "뭐야 내 스터디 돌려줘요222", sender: "USER"),
      Message(text: "언ㄷ햐ㅐ요요ㅕ", sender: "Admin"),
      Message(text: "뭐야 내 스터디 돌려줘요", sender: "Admin"),
      Message(text: "마지막 메시지", sender: "Admin"),
    ]
}
