//
//  DatePickerSheet.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct DatePickerSheet: View {
    @ObservedObject var dateStore: DateStore = DateStore()
    
    @Binding var isShowingDateSheet: Bool
    @Binding var startDate: Date
    @Binding var endDate: Date
//    @Binding var startTime: Date
       
       var body: some View {
           VStack(alignment: .center) {
               HStack {
                   Text("날짜 설정하기")
                   Spacer()
                   
                   Button {
                       isShowingDateSheet = false
                   } label: {
                       Image(systemName: "xmark")
                           .foregroundColor(Color.black)
                   }
                   
               }
               Divider()
               // 시작일자 설정
               Spacer().frame(height: 30)
               DatePicker(selection: $startDate) {
                   Text("시작일자")
               }
               .environment(\.locale, Locale(identifier: "ko_KR"))
              
               Divider()
               // 마감일자 설정
               Spacer().frame(height: 30)
               DatePicker(selection: $endDate, displayedComponents: .date) {
                   Text("마감일자")
               }
               .environment(\.locale, Locale(identifier: "ko_KR"))
               
               Divider()
               // 설정하기
               Button {
                   dateStore.addDate(id: UUID(), startDate: startDate, endDate: endDate)
                   isShowingDateSheet = false
               } label: {
                   Text("설정하기")
                       .foregroundColor(Color.black)
               }
               
           }
           .padding()
           .font(.title2)
    }
}

//struct DatePickerSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        DatePickerSheet(isShowingDateSheet: .constant(true), startDate: .constant(Date()), endDate: .constant(Date()), startTime: .constant(Date()))
//    }
//}
