//
//  Date.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation


struct DateCalculate{
    var date: Date = Date()
    var formatter: DateFormatter = DateFormatter()
    
    init(){
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    func currentTime() -> String {
        let kr = formatter.string(from: date)
        return kr
    }
    
    func caluculateTime(_ dateString: String) -> String{
        let current = self.currentTime()
        
        let difference = formatter.date(from: current)! - formatter.date(from: dateString)!
        
        return difference.stringFromTimeInterval()
    }
}

enum TimeDiffereceType: String {
    case defalut = "방금 전"
    case minute = "분 전"
    case hour = "시간 전"
    case day = "일 전"
    case month = "달 전"
    case year = "년 전"
}


extension TimeInterval{

    func stringFromTimeInterval() -> String {

        let time = NSInteger(self)
        
        let year = (time / 3600) / 8064
        if year != 0 {return String(year) + TimeDiffereceType.year.rawValue }
        
        let month = (time / 3600) / 672
        if month != 0 {return String(month) + TimeDiffereceType.month.rawValue }
        
        let days = (time / 3600) / 24
        if days != 0 {return String(days) + TimeDiffereceType.day.rawValue }
        
        let hours = (time / 3600)
        if hours != 0 {return String(hours) + TimeDiffereceType.hour.rawValue }
        
        let minutes = (time / 60) % 60
        if minutes != 0 {return String(minutes) + TimeDiffereceType.minute.rawValue }
        
        let seconds = time % 60
        if seconds != 0 {return TimeDiffereceType.defalut.rawValue }
        
        return TimeDiffereceType.defalut.rawValue
    }
}

extension Date {
    
    public static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    // 알림이 발생한 시간을 문자열로 변환 (예: "3시간 전")
    func timeSince(_ date: Date) -> String {
        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: date, to: Date())
        if let years = components.year, years > 0 { return "\(years)년 전" }
        if let months = components.month, months > 0 { return "\(months)달 전" }
        if let days = components.day, days > 0 { return "\(days)일 전" }
        if let hours = components.hour, hours > 0 { return "\(hours)시간 전" }
        if let minutes = components.minute, minutes > 0 { return "\(minutes)분 전" }
        return "방금 전"
    }
    
    func dateComponent(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func dateComponent(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    // 날짜를 문자열로 변환
    func dotString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
    
    
    func toString() -> String{
        let formatter: DateFormatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: self)
    }
}



