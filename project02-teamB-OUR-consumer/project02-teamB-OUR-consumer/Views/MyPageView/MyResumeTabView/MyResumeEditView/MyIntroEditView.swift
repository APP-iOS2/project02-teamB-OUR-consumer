//
//  MyIntroEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/23.
//

import SwiftUI

struct MyIntroEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var intro: String = ""
    
    @State var isDeleteItemAlert: Bool = false
    
    var body: some View {
        ScrollView {
            Divider()
                .padding(.top, 5)
            
            VStack(alignment: .leading) {
                Text("자기소개")
                    .font(.system(size: 16))
                    .bold()
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 2)
                    .overlay {
                        TextEditor(text: $intro)
                            .padding()
                    }
                    .frame(minHeight: 300)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action : {
                        self.mode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                    })
                
            }
            .padding()
            .navigationTitle("자기소개")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // 완료 버튼
                        dismiss()
                    } label: {
                        Text("완료")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(mainColor)
                            .cornerRadius(5)
                    }
                }
            }
        }
        
    }
}

struct MyIntroEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyIntroEditView()
    }
}
