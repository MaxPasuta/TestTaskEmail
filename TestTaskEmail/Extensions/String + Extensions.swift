//
//  String + Extensions.swift
//  TestTaskEmail
//
//  Created by Максим Пасюта on 31.03.2022.
//

import Foundation


extension String {
    
    func isValid() -> Bool {
        
        let format = "SELF MATCHES %@"
        let regEX = "[a-zA-Z0-9_]+@[a-zA-Z]+\\.[a-zA-Z]{2,}"
        return NSPredicate(format: format, regEX).evaluate(with: self)
    }
}
