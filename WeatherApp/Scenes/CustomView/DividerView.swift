//
//  SeparatorView.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/12/24.
//

import UIKit
import SnapKit

final class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(1.0)
        }
    }
    
    private func configureUI() {
        backgroundColor = .lightGray
    }
}
