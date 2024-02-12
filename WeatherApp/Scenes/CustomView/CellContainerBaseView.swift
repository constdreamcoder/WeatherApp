//
//  CellContainerBaseView.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/12/24.
//

import UIKit

final class CellContainerBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
}
