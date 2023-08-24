//
//  ButtonMainView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct ButtonMainView: View {
    @ObservedObject var dateStore: DateStore = DateStore()
    
    @State var isShowingDateSheet: Bool = false
    @State var isShowingPersonSheet: Bool = false
    
//    @State var startDate: Date
//    @State var endDate: Date
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var number: Int
    
//    @State var number: Int = 1
    
    var body: some View {
            VStack {
                HStack {
                    Button {
                        isShowingDateSheet.toggle()
                    } label: {
                        VStack {
                            Text("기간 설정")
                                .padding().frame(width: 150)
                                .foregroundColor(Color.black)
                            
                        }
                       
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 8))
                    .shadow(radius: 8)
                    .sheet(isPresented: $isShowingDateSheet) {
                        DatePickerSheet(dateStore: DateStore(), isShowingDateSheet: $isShowingDateSheet, startDate: $startDate, endDate: $endDate)
                            .presentationDetents([.fraction(0.45)])
                       
                    }
                    Text("시작: \(startDate.formatted(.dateTime))")
                    Text("마감: \(endDate.formatted(.dateTime))")
                }
             
                    HStack {
                        Button {
                            isShowingPersonSheet.toggle()
                        } label: {
                            Text("인원수 선택")
                                .padding().frame(width: 150)
                                .foregroundColor(Color.black)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                        .shadow(radius: 8)
                        .sheet(isPresented: $isShowingPersonSheet) {
                            PersonnelSheet(isShowingPersonSheet: $isShowingPersonSheet, number: $number)
                                .presentationDetents([.fraction(0.45)])
                        }
                        
                        Spacer().frame(width: 137)
                        Text("인원: \(number)명")
                        
                    }
                       
                
            }
        }
    }


//struct ButtonMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonMainView(startDate: Date(), endDate: Date())
//    }
//}
