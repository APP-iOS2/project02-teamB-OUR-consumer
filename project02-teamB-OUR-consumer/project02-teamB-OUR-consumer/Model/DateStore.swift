
import SwiftUI
import Combine



class DateStore: ObservableObject {
    @Published var times: [DateModel] = [DateModel(startDate: Date(), endDate: Date())]
    
    func addDate(id: UUID, startDate: Date, endDate: Date) {
        let newDate: DateModel = DateModel(startDate: startDate, endDate: endDate)
        times.append(newDate)
    }
    
    func removeDate(index: DateModel) {
        times.removeAll { $0.id == index.id }
    }
    
    func formattedDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.locale = Locale(identifier: "ko_KR")
           formatter.dateFormat = "yy년 M월 dd일 HH시 mm분" // yy년 M월 dd일
           return formatter.string(from: date)
       }
       
       func immobilizeEndTime(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.locale = Locale(identifier: "ko_KR")
           formatter.dateFormat = "yy년 M월 dd일 HH시 mm분"
           return formatter.string(from: date)
       }
}
