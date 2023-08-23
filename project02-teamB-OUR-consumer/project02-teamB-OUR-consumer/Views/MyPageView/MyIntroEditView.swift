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
                    
                    //MARK: Intro에 삭제 기능은 없어도 될 것 같아요!
                        HStack{
                            Spacer()
                            Button {
                                isDeleteItemAlert.toggle()
                            } label: {
                                Text("삭제하기")
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                
                            }
                            .foregroundColor(.gray)
                            .alert(isPresented: $isDeleteItemAlert) {
                                Alert(title: Text("삭제하시겠습니까?"), primaryButton: .destructive(Text("삭제"), action: {
                                    //삭제 함수
                                    dismiss()
                                }), secondaryButton: .cancel(Text("취소")))
                            }
                            Spacer()
                        }
                        .padding(.vertical, 20)
                    
                }
                .padding()
                .navigationTitle("자기소개")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            // 완료 버튼
                        } label: {
                            Text("완료")
                        }
                        .buttonStyle(.bordered)
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
