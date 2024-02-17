//
//  UITextField + Extension.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.01.2024.
//

import UIKit

class PaddedTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = leftView
        self.leftViewMode = .always
    }
}
