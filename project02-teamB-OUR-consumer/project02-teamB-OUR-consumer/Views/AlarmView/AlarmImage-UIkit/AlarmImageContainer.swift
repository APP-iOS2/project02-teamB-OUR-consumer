//
//  AlarmImageView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/25.
//

import UIKit
import SwiftUI
import SnapKit


class AlarmImageContainer: UIView{
    
    // 선언
    private let alarmTabBarImage: AlarmImageView = {
        let view = AlarmImageView(frame: .zero)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(Color.gray)
        label.text = "알림"
        return label
    }()
    
    func addDot() {
        alarmTabBarImage.addDot()
    }

    func removeDot() {
        alarmTabBarImage.removeDot()
    }

    func selected(uicolor: UIColor){
        alarmTabBarImage.settingColor(color: uicolor)
        titleLabel.textColor = uicolor
    }
    
    func unSelected(color: Color){
        alarmTabBarImage.settingColor(color: UIColor(color))
        titleLabel.textColor = UIColor(color)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add SubView
        self.addSubview(alarmTabBarImage)
        self.addSubview(titleLabel)
        
        alarmTabBarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(alarmTabBarImage.snp.bottom).offset(1)
            make.centerX.equalTo(alarmTabBarImage.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init fatalError")
        
    }
}
