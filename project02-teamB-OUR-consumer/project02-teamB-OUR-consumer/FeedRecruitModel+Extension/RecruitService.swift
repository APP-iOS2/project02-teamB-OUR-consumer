//
//  RecruitService.swift
//  project02-teamB-OUR-consumer
//
//  Created by woojin Shin on 2023/08/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI
import FirebaseFirestoreSwift

//@ServerTimestamp => timestamp 매핑용 프로퍼티래퍼


//Encode하는 데이터객체 Dictinary로 변환해주기
extension Encodable {
    
    func toDictionary() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary = [String: Any]()

        for (label, value) in mirror.children {
            if let label {
                if let _ = value as? DocumentID<String> { //=> @DocumentID 프로퍼티래퍼 사용할때 필터해주기위해 사용했던 구문.

                } else {
                    dictionary[label] = value
                }
            }

        }
        return dictionary
    }
    
    ///nil 인 필드 제외하고 생성
    func toDictionaryNotNil() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary = [String: Any]()
        
        for (label, value) in mirror.children {
            if let label {
                if let _ = value as? DocumentID<String> {   //=> @DocumentID 프로퍼티래퍼 사용할때 필터해주기위해 사용했던 구문.
                    
                } else if !(Mirror(reflecting: value).displayStyle == .optional && Mirror(reflecting: value).children.isEmpty) {
                    dictionary[label] = value
                }
            }
        }
        return dictionary
    }

}



//Data객체 예시  전부 옵셔널 처리
//struct FeedRecruitModelTemp: Codable, Identifiable {
//
//    @DocumentID var id: String?
//    var creator: String?
//    var content: String?
//    var location: String?
//    var privateSetting: Bool?
//    var reportCount: Int?
//    var createdAt: Double = Date().timeIntervalSince1970
//    var feedImagePath: String?
//
//    var createdDate: String {
//        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
//
//        let dateFormatter: DateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ko-KR")
//        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
//        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
//
//        return dateFormatter.string(from: dateCreatedAt)
//    }
//
//    //    var id: String?     //키값 문서 추가할때 자동으로 따서 넣어줌.
//    //    var geoPoint: GeoPoint?     // 위도 90도 경도 90도 이상으로 하면 오류남
//    //    @ServerTimestamp var timeData: Timestamp? //현재 getDocument 했을때 Codable 오류 남.  NSDate 로 변환해줘야 에러가 안남.
//
//}

//만약에 이게 등록쪽에서 쓰는 구조
//struct FeedRecruitModelTest: Codable, Identifiable {
//
//    @DocumentID var id: String?
//    var creator: String?
//    var content: String?
//    var location: String?
//    var privateSetting: Bool?
//    var reportCount: Int?
//    var createdAt: Double = Date().timeIntervalSince1970
//    var feedImagePath: String?
//
//    var createdDate: String {
//        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
//
//        let dateFormatter: DateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ko-KR")
//        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
//        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
//
//        return dateFormatter.string(from: dateCreatedAt)
//    }
//
//}




///예시로 만들어 놓은 Feed뷰임.  쓰는 곳 없음
final class FeedViewModelTemp: ObservableObject {
    let service = RecruitService()
    
    //@Published var feedTable = FeedRecruitModel
    @Published var feedTables = [FeedRecruitModel]()
    @Published var feedDics = [[String : Any]]()
    @Published var feedDic = [String : Any]()
    @Published var limit: Int = 0
    @Published var whereContentData: String = ""
    @Published var isWorking: Bool = false
    
    
    init() { }
    
    
    func fetchAll() {
        self.feedTables.removeAll() //있는 데이터 삭제
        
        if self.whereContentData != "" {
            service.fetchAll(collection: .posts, whereField: "content", whereType: .equal, whereData: whereContentData, limitCount: limit) { results in
//                self.feedDics = results
                self.feedTables = results
            }
        } else {
            service.fetchAll(collection: .posts, limitCount: limit) { results in
//                self.feedDics = results
                self.feedTables = results
            }
        }
    }
    
    func fetchOneData( documentID: String ) {
        service.fetchOneData( collection: .posts, documentID: documentID ) { result in
//            self.feedDic = result
           // self.feedTable = result
        }
    }

    func updateField( documentID: String, data: FeedRecruitModel ) {
        service.update( collection: .posts, documentID: documentID, data: data )
    }
    
    func addDocument( data: FeedRecruitModel ) {
        service.add(collection: .posts, data: data)
    }
    
    func removeData( documentID: String ) {
        service.remove( collection: .posts, documentID: documentID )
    }
    
}



/// Recruit Firebase CRUD
final class RecruitService {

    ///Firestore DB
    let db = Firestore.firestore()
    
    var isWorking: Bool = false
    
    ///Service  Enum
    struct Recruit {
        /// 컬렉션 Enum
        enum collection: String {
            case posts = "posts"
            case study = "study"
            case resume = "resumes"
            case users = "users"
            case follow = "follow"
            case studypost = "StudyPosts"
            
        }
        
        /// 조건타입 Enum
        enum WhereType {
            case equal          // ==
            case lessThan       // <
            case overThan       // >
            case lessOrEqual    // <=
            case overOrEqual    // >=
            case notEqual       // !=
        }
        
        /// 정렬타입 Enum
        enum OrderbyType {
            case asc        //오름차순
            case desc       //내림차순
        }
        
    }
    

    ///READ, FETCH 1개 데이터
    ///- collection : 컬렉션명 Enum
    ///- documentID: 문서번호
    ///- completion: 해당 문서번호에 해당하는 형식의 객체를 파라미터로 return 시켜준다.
    func fetchOneData<T: Codable>( collection col: Recruit.collection, documentID docID: String, completion: @escaping (T) -> Void ) {
        let docRef: DocumentReference = db.collection("\(col.rawValue)").document(docID)

        docRef.getDocument(as: T.self) { result in
            switch result {
            case .success(let success):
                print("Fetch 성공 : \(success)")

                completion(success)

            case .failure(let error):
                print("Fetch중 에러 : \(error.localizedDescription)")
                
            }
        }
    }

    
    ///Dictionary 형태로 Return
    ///- collection : 컬렉션명 Enum
    ///- documentID: 문서번호
    ///- completion: 해당 문서번호에 해당하는 형식의 객체를 파라미터로 return 시켜준다.
    func fetchOneData( collection col: Recruit.collection, documentID docID: String, completion: @escaping ([String : Any]) -> Void ) {
        let docRef: DocumentReference = db.collection("\(col.rawValue)").document(docID)

        docRef.addSnapshotListener { document, error in
            if let document = document, document.exists {
                let dataDescription = document.data()//.map(String.init(describing:)) ?? "nil"
                
                if let dataDescription {
                    completion(dataDescription)
                } else {
                    completion([:])
                }
                
            } else {
                print("Document does not exist")
                return
            }
        }
        
    }
    
    

    ///   onAppear()에서 호출바랍니다.
    ///서버에서 가져올 데이터를 담을 구조체( 데이터 객체 )의 배열을 클로저 매개변수로 반환
    ///Data의 필드명이 데이터객체의 프로퍼티명과 일치하지 않거나 없을 경우 런타임 에러가 나기때문에 사용을 비추천 ->> 프로퍼티를 옵셔널로 처리하면 에러 안남.
    /// - collection: 컬렉션명 Enum
    /// - whereField: 조건을 입력할 Field명 ( String? )
    /// - whereType: 조건 타입 ex) equalTo( == ), lessThan( < ) etc...
    /// - whereData: 조건 값 ( Any? )
    /// - orderField: 정렬 Field명 ( String? )
    /// - orderType: 정렬 (오름차순, 내림차순) Enum
    /// - limitCount: 데이터 fetch개수 ==> 0이면 전체조회
    /// - completion: [ T ] -> Void  ==> 실제 데이터배열 Return
    func fetchAll<T: Codable>( collection col: Recruit.collection,
                               whereField condition: String? = nil,
                               whereType type: Recruit.WhereType? = nil,
                               whereData: Any? = nil,
                               orderField orderby: String? = nil,
                               orderType: Recruit.OrderbyType = .asc,
                               limitCount: Int = 0,
                               completion: @escaping ([T]) -> Void ) {
        
        var colRef: Query
        
        if let condition {
            if let whereData, let type {
                switch type {
                case .equal:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isEqualTo: whereData)
                case .lessThan:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isLessThan: whereData)
                case .overThan:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isGreaterThan: whereData)
                case .lessOrEqual:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isLessThanOrEqualTo: whereData)
                case .overOrEqual:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isGreaterThanOrEqualTo: whereData)
                case .notEqual:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isNotEqualTo: whereData)
                }
            } else {
                print("Err: 매개변수 whereData에 값을 입력하지 않았습니다.")
                return
            }
            
        } else {
            colRef = db.collection("\(col.rawValue)")
        }
        
        
        //정렬
        if let orderby {
            switch orderType {
            case .asc:
                colRef = colRef.order(by: orderby)
            case .desc:
                colRef = colRef.order(by: orderby, descending: true)
            }
            
        }
        
        
        if limitCount != 0 {
            colRef = colRef.limit(to: limitCount)
        }
        
        
        colRef.getDocuments() { [self] snapShot, error in
            if let error {
                print("문서번호 못가져옴 : \(error)")
                completion([])
                
            } else {
                var fetchedDatas: [T] = []   //초기화
                
                if let snapShot {
                    for document in snapShot.documents {
                        
                        let docID = document.documentID
 
//                        print("문서ID :  \(document)")
                        
                        db.collection("\(col.rawValue)").document(docID).getDocument(as: T.self) { result in
                            switch result {
                            case .success(let success):
//                                print("Fetch 성공 : \(success)")
                                fetchedDatas.append(success)
                                
                                completion(fetchedDatas)
                                
                            case .failure(let error):
                                print("Fetch중 에러 : \(error.localizedDescription)")
                                
                            }
                        }
                        
//                        do {
//                            let jsonData = try JSONSerialization.data(withJSONObject: documentData, options: [])
////                            print("Json데이터 : \(jsonData)")
//                            let decoder = JSONDecoder()
//                            let decodedData = try decoder.decode(T.self, from: jsonData)
//
//                            fetchedDatas.append(decodedData)
//
//                        } catch {
//                            print("Data가져와서 Decoding중 오류: \(error.localizedDescription)")
//                        }
                        
                    }
//                    print("데이터 개수 \(fetchedDatas.count)")
                    
                    
                }
                
            }

        }
    
    }
    
    
    ///Dictionary 형식으로 결과값 반환
    ///where는 데이터를 가져오는 조건이지 검색용필터가 아닙니당
    ///배열로 가져옴 [[String : Any]] //
    ///   onAppear()에서 호출바랍니다.
    /// - collection: 컬렉션명 Enum
    /// - whereField: 조건을 입력할 Field명 ( String? )
    /// - whereType: 조건 타입 ex) equalTo( == ), lessThan( < ) etc...
    /// - whereData: 조건 값 ( Any? )
    /// - orderField: 정렬 Field명 ( String? )
    /// - orderType: 정렬 (오름차순, 내림차순) Enum
    /// - limitCount: 데이터 fetch개수 ==> 0 이면 전체조회
    /// - completion: [[String : Any]] -> Void  ==> 실제 데이터배열 Return
    func fetchAll( collection col: Recruit.collection,
                   whereField condition: String? = nil,
                   whereType type: Recruit.WhereType? = nil,
                   whereData: Any? = nil,
                   orderField orderby: String? = nil,
                   orderType: Recruit.OrderbyType = .asc,
                   limitCount: Int = 0,
                   completion: @escaping ([[String : Any]]) -> Void ) async {
        
        var colRef: Query
        
        
        if let condition {
            if let whereData, let type {
                switch type {
                case .equal:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isEqualTo: whereData)
                case .lessThan:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isLessThan: whereData)
                case .overThan:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isGreaterThan: whereData)
                case .lessOrEqual:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isLessThanOrEqualTo: whereData)
                case .overOrEqual:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isGreaterThanOrEqualTo: whereData)
                case .notEqual:
                    colRef = db.collection("\(col.rawValue)").whereField("\(condition)", isNotEqualTo: whereData)
                }
            } else {
                print("Err: 매개변수 whereData에 값을 입력하지 않았습니다.")
                return
            }
            
        } else {
            colRef = db.collection("\(col.rawValue)")
        }
        
        //정렬
        if let orderby {
            switch orderType {
            case .asc:
                colRef = colRef.order(by: orderby)
            case .desc:
                colRef = colRef.order(by: orderby, descending: true)
            }
            
        }
        
        //데이터 갯수제한
        if limitCount != 0 {
            colRef = colRef.limit(to: limitCount)
        }
                
        //문서의 변화가 생기면 감지.
        colRef.addSnapshotListener { snapShot, error in
            if let error {
                print("문서번호 못가져옴 : \(error.localizedDescription)")
                completion([[:]])
                
            } else {
                var fetchedDatas = [[String : Any]]()   //초기화
                
                if let snapShot {
                    
                    for document in snapShot.documents {
                        
                        let documentData = document.data()
//                        print("문서임 = \(documentData)")
                        
                        fetchedDatas.append(documentData)
                        
                        
                    }
                    print("데이터 개수 \(fetchedDatas.count)")
                    completion(fetchedDatas)
                    
                }
                
            }
        }
    
    }
    
    ///FireStore Update
    ///data에 정의된 해당 필드만 update 된다.
    ///- collection: collection 선택
    ///- documentID: 문서번호
    ///- data: 업데이트할 Data 객체
    func update<T: Codable>( collection col: Recruit.collection, documentID docID: String, data: T ) {
        
        guard docID != "" else { return }
        
        let docRef = db.collection("\(col.rawValue)").document(docID)
        
        var dataDic = [String : Any]()
        
        
        dataDic = data.toDictionaryNotNil() //nil값인 프로퍼티를 제외하고 Dictionary 형식으로 변환
        
        //트랜잭션 -> 안해도 되는거 같은데... 각각 다른 환경에서 테스트 안해봐서 모르겠다...
        //        db.runTransaction({ (transaction, _) -> Any? in
        //            transaction.updateData( dataDic, forDocument: docRef )
        //
        //        }) { (object, error) in
        //            if let error {
        //                print("Error updating : \(error.localizedDescription)")
        //            } else {
        //                print("Update 완료 : \(object!)")
        //            }
        //
        //        }
        
        docRef.updateData( dataDic ) { err in
            if let err {
                print("Error updating : \(err.localizedDescription)")
            } else {
                print("Update 완료")
            }
        }
        
    }
    
    
    ///ADD 추가 DocumentID는 알아서 따진다. => addDocument 메서드 사용시
    ///데이터 객체로 addDocument 사용시 nil값인 프로퍼티들은 생략이 되기때문에 구조 그대로 가져가기 위해서 Dictionary로 변환하여 add 해준다.
    ///addDocument 메서드를 통해 id값을 생성 후 해당 id값을 id필드를 구현하여 update해준다.
    ///- collection: 컬렉션 Enum
    ///- data: 데이터객체 where Encodable
    func add<T: Encodable>( collection col: Recruit.collection, data: T ) {
                
        let colRef: CollectionReference = db.collection("\(col.rawValue)")
        
//        var dicData = [String : Any]()
//        print("data :\n \(data)")
//        dicData = data.toDictionary()   //Dictionary형태로 변환
//        print("dicData =\n \(dicData)")
        
        var newDocRef: DocumentReference?
        
        do {
            newDocRef = try colRef.addDocument( from: data ) { error in
                if let error = error {
                    print("신규추가 중 에러 : \(error.localizedDescription)")
                    
                } else {
                    print("추가완료 \(newDocRef!.documentID)")
//                    if let newDocRef {
//                        let UID = newDocRef.documentID
//                        colRef.document("\(UID)").updateData( ["id" : UID] ) { err in
//                            if let err {
//                                print("Error updating : \(err.localizedDescription)")
//                            } else {
//                                print("ADD: UID Update 완료 UID = \(UID)")
//                            }
//                        }
//
//                    }
                }
            }
        } catch {
            print("신규추가 중 에러2 : \(error.localizedDescription)")
        }
    }

    
    ///REMOVE 삭제
    ///- collection: 컬렉션 Enum
    ///- documentID: 삭제하려는 문서번호 ( 보통 객체의 id 값 )
    func remove( collection col: Recruit.collection, documentID docID: String ) {
        guard docID != "" else {
            return
        }
        
        let dbRef: DocumentReference = db.collection("\(col.rawValue)").document(docID)
        
        dbRef.delete() { error in
            if let error {
                print("Delete 에러 : \(error.localizedDescription)")
            } else {
                print("Delete 완료")
            }
        }
        
    }
    
    
    ///한번에 여러작업을 처리할때 사용
    ///ex) post 컬랙션에 add하고 post ID값을 my컬랙션에 업데이트 한다.
    func makeBatch( collection col: Recruit.collection, documentID docID: String ) {
//        let docRef = db.collection("\(col.rawValue)").document(docID)
//
//        let batch = db.batch() //작업박스를 생성
        
        //처리할거 하고 commit하기
        
        //batch.setData(<#T##data: [String : Any]##[String : Any]#>, forDocument: <#T##DocumentReference#>)
        //batch.updateData(<#T##fields: [AnyHashable : Any]##[AnyHashable : Any]#>, forDocument: <#T##DocumentReference#>)
        //batch.deleteDocument(<#T##document: DocumentReference##DocumentReference#>)
        
//        batch.commit(){ err in
//        if let err = err {
//            print("Error writing batch \(err)")
//        } else {
//            print("Batch write succeeded.")
//        }
    }
    
}
