//
//  StatusLabel.swift
//  TestTaskEmail
//
//  Created by Максим Пасюта on 21.03.2022.
//

import Foundation
import UIKit

class StatusLabel: UILabel{
        
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has been implemented")
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
        text = "Check your email"
        textColor = #colorLiteral(red: 0.9450980392, green: 0.9333333333, blue: 0.862745098, alpha: 1)
        font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setNotValidSetting() {
        text  = "Mail is not valid. Example: name@domain.ru"
        textColor = #colorLiteral(red: 0.5215686275, green: 0.1098039216, blue: 0.05098039216, alpha: 1)
        
    }
    
    private func setValidSetting() {
        text  = "Mail is valid"
        textColor = #colorLiteral(red: 0.1960784314, green: 0.3411764706, blue: 0.1019607843, alpha: 1)
    }
    
    public func setDefaultSetting(){
        configure()
    }
}
