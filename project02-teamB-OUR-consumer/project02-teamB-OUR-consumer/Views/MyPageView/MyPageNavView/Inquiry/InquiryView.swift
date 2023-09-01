//
//  MyChatRow.swift
//  project02-teamB-OUR-consumer
//
//  Created by 신희권 on 2023/08/22.
//


/* MARK: -
 관리자와 채팅 될 수 있도록만 대략적으로 구성만 해놨습니다.
 프로토 타입정도로 생각 해주세요
 뷰에있는 함수들은 나중에 정리하겠습니다!
 */


import SwiftUI
import Firebase

struct InquiryView: View {
    @State var name = "김멋사"//로그인한 유저의 닉네임
    @State var chatText: String = ""
    var ref = Database.database().reference().child("Inquiry") // 리얼타임 초기 저장소
    @State var messages: [Message] = [] //DB에서 메시지 불러와 저장하는 배열
    var body: some View {
        VStack {
            ScrollView {
                
                ForEach($messages) { $message in
                    InquiryRow(name: name, message: $message)
                }
                
                .listRowSeparator(.hidden) //줄 숨기기
                
            }
            .navigationTitle("1대1 문의")
            .listStyle(.plain)
            
            if messages.isEmpty {
                Spacer()
                    Text("채팅을 입력 해 상담을 시작 해 보세요")
            }
            HStack {
                TextField("채팅을 입력 해 주세요", text: $chatText)
                Button {
                    //Firebase 실행
                    sendMessage(message: Message(text: chatText, sender: name))
                    chatText = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .padding(10)
            }
            
        }
        .task {
            loadMessagesFromFirebase() //DB에서 패치
        }
    }
    
    func loadMessagesFromFirebase() {
        ref.child("\(name)/messages").queryOrdered(byChild: "createdAt").observe(.value) { (snapshot) in
            //DB위치에서 createdAt으로 정렬해서 옵저브
            self.messages = []
            
            for child in snapshot.children { // 모든 데이터 불러와서
                if let snapshot = child as? DataSnapshot { // 형변환
                    if let messageData = snapshot.value as? [String: Any],
                       let text = messageData["text"] as? String,
                       let sender = messageData["sender"] as? String{
                        messages.append(Message(text: text, sender: sender))
                        //정상적으로 형변환이 되면 메시지 배열에 추가
                    }
                }
            }
        }
    }
    
    func sendMessage(message: Message) {
        let message = Message(text: message.text, sender: message.sender)
        //입력한 텍스트 받아와서 객체로 생성
        do {
            let data = try JSONEncoder().encode(message)
            let json = try JSONSerialization.jsonObject(with: data)
            //객체를 인코딩해 DB로 입력
            ref.child("\(name)/messages").childByAutoId().setValue(json){ (error, ref) in
                
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                } else {
                    print("Message sent successfully!")
                }
            }
        }
        catch {
            print("an error occurred", error)
        }
    }
}

struct MyChatRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            InquiryView()
        }
    }
}
