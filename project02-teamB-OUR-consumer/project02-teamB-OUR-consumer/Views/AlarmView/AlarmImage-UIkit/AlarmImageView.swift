//
//  AlarmImageView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/25.
//

import UIKit
import SnapKit


private enum Const {    
    static let borderWidth: Double = 1
    static let imageOuterSpacing = Self.borderWidth + 4.0
    static let greenDotOuterSpacing = 1
    static let greenDotViewInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 2)
    static let greenDotViewSize = CGSize(width: 6, height: 6)
    
    // shapeLayer
    static let gradationWidth = 2.0
}

class AlarmImageView: UIView {
    private let containerView: RoundView = {
        let roundView = RoundView()
        roundView.backgroundColor = .clear
        roundView.isUserInteractionEnabled = false
        roundView.clipsToBounds = true
        return roundView
    }()
    
    private let alarmImageView: RoundImageView = {
        let image = RoundImageView()
        image.image = UIImage(systemName: "bell.fill")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
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
            $0.edges.equalToSuperview().inset(Const.greenDotOuterSpacing)
        }
        
        return roundView
    }()
    
    
    func settingColor(color: UIColor){
        alarmImageView.tintColor = color
    }
    
    
//    1. 처음에 데이터가 있는지 없는지 확인 , ViewModel, UserDefaults
//    2 - 1. 초기 앱 로딩시 알람이 있으면 addDot호출
//    2 - 2. 초1기 앱 로딩시 알람이 없으면 아무것도 호출하지 않는다.
//    3. 알람의 존재여부에 따라 0이 되면 removeDot 호출
//    4. 알람의 존재여부에 따라 1이상이 되면 addDot 호출
    
    func removeDot(){
        greenDotContainerView.removeFromSuperview()
    }
    
    func addDot(){
        self.addSubview(self.greenDotContainerView)
        self.greenDotContainerView.snp.makeConstraints {
            $0.right.top.equalToSuperview().inset(Const.greenDotViewInset)
            $0.size.equalTo(Const.greenDotViewSize)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.containerView)
        self.addSubview(self.greenDotContainerView)
        self.containerView.addSubview(self.alarmImageView)
        
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.alarmImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()//.inset(Const.imageOuterSpacing)
        }
        
        self.greenDotContainerView.snp.makeConstraints {
            $0.right.top.equalToSuperview().inset(Const.greenDotViewInset)
            $0.size.equalTo(Const.greenDotViewSize)
        }
    }
    
}
