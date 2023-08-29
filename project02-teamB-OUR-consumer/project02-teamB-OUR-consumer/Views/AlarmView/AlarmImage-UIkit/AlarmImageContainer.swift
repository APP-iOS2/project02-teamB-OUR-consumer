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
    private let alarmViewImage: AlarmImageView = {
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
    
    
    func setAlarmImage(color: UIColor){
        alarmViewImage.settingColor(color: color)
    }
    func setLabel(color: Color){
        titleLabel.textColor = UIColor(color)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add SubView
        self.addSubview(alarmViewImage)
        self.addSubview(titleLabel)
        
        alarmViewImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(25)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(alarmViewImage.snp.bottom).offset(1)
            make.centerX.equalTo(alarmViewImage.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("required init fatalError")
        
    }
}
