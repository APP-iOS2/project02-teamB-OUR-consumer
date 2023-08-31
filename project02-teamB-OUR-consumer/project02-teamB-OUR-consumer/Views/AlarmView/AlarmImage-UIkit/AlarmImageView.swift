//
//  AlarmImageView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/25.
//

import UIKit
import SnapKit


// 레이아웃 및 시각적 요소를 위한 상수들을 저장하는 열거형
private enum Const {
    static let borderWidth: Double = 1  // 테두리의 두께
    static let imageOuterSpacing = Self.borderWidth + 4.0  // 이미지 외부 여백
    static let redDotOuterSpacing = 1  // 빨간색 점의 외부 여백
    static let redDotViewInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 2)  // 빨간색 점의 여백
    static let redDotViewSize = CGSize(width: 6, height: 6)  // 빨간색 점의 크기
}

// 알람 아이콘과 빨간색 점(뱃지)을 표시하기 위한 UIView 클래스
class AlarmImageView: UIView {

    // 알람 아이콘을 담을 컨테이너 뷰
    private let containerView: RoundView = {
        let roundView = RoundView()
        roundView.backgroundColor = .clear
        roundView.isUserInteractionEnabled = false
        roundView.clipsToBounds = true
        return roundView
    }()
    
    // 실제 알람 아이콘 이미지 뷰
    private let alarmImageView: RoundImageView = {
        let image = RoundImageView()
        image.image = UIImage(systemName: "bell.fill")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    // 빨간색 점(뱃지)을 담을 컨테이너 뷰
    private let greenDotContainerView: RoundView = {
        let roundView = RoundView()
        roundView.isUserInteractionEnabled = false
        roundView.backgroundColor = .white
        roundView.clipsToBounds = true
        
        let greenDotView: RoundView = {
            let view = RoundView()
            view.backgroundColor = .red
            return view
        }()
        
        roundView.addSubview(greenDotView)
        
        greenDotView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Const.redDotOuterSpacing)
        }
        
        return roundView
    }()
    
    // 알람 아이콘의 색상을 설정하는 함수
    func settingColor(color: UIColor){
        alarmImageView.tintColor = color
    }
    
    // 빨간색 점(뱃지)을 제거하는 함수
    func removeDot(){
        greenDotContainerView.removeFromSuperview()
    }
    
    // 빨간색 점(뱃지)을 추가하는 함수
    func addDot(){
        self.addSubview(self.greenDotContainerView)
        self.greenDotContainerView.snp.makeConstraints {
            $0.right.top.equalToSuperview().inset(Const.redDotViewInset)
            $0.size.equalTo(Const.redDotViewSize)
        }
    }
    
    // 뱃지 상태 업데이트
    func updateDot(hasUnreadData: Bool) {
        if hasUnreadData {
            addDot()
        } else {
            removeDot()
        }
    }
    
    // 필수 초기화 함수 (Interface Builder 사용을 위함, 현재는 사용되지 않음)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 커스텀 초기화 함수
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 컨테이너 뷰를 메인 뷰에 추가
        self.addSubview(self.containerView)
        // 빨간색 점(뱃지) 컨테이너 뷰를 메인 뷰에 추가
        self.addSubview(self.greenDotContainerView)
        // 알람 아이콘 이미지 뷰를 컨테이너 뷰에 추가
        self.containerView.addSubview(self.alarmImageView)
        
        // AutoLayout 설정
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.alarmImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.greenDotContainerView.snp.makeConstraints {
            $0.right.top.equalToSuperview().inset(Const.redDotViewInset)
            $0.size.equalTo(Const.redDotViewSize)
        }
    }
}

//    1. 처음에 데이터가 있는지 없는지 확인 , ViewModel, UserDefaults
//    2 - 1. 초기 앱 로딩시 알람이 있으면 addDot호출
//    2 - 2. 초1기 앱 로딩시 알람이 없으면 아무것도 호출하지 않는다.
//    3. 알람의 존재여부에 따라 0이 되면 removeDot 호출
//    4. 알람의 존재여부에 따라 1이상이 되면 addDot 호출
