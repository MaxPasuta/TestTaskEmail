//
//  VerificationButton.swift
//  TestTaskEmail
//
//  Created by Максим Пасюта on 21.03.2022.
//

import Foundation
import UIKit

class VerificationButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public var isValid = false {
        didSet {
            if self.isValid{
                setValidSetting()
                
            }
            else {
                setNotValidSetting()
            }
        }
    }
    
    private func configure(){
        backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9333333333, blue: 0.862745098, alpha: 1)
        setTitle("Verification Button", for: .normal)
        let color = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: "Avenir Book", size: 17)
//        isEnabled = false
//        alpha = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    private func setNotValidSetting() {
        isEnabled = false
        alpha = 0.5
    }
    
    private func setValidSetting() {
        isEnabled = true
        alpha = 1
    }
    
    public func setDefaultSetting(){
        configure()
    }
}
