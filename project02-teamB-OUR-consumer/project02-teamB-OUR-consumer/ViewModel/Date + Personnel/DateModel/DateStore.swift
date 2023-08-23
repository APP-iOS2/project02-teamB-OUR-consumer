
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
}
