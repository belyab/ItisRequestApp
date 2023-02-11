//
//  DesignableTextField.swift
//  ITISRequest
//
//  Created by Эльмира Байгулова on 21.03.2022.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    // цвета рамки
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
           self.layer.borderColor = borderColor.cgColor
        }
    }
    
    // ширина границы 
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
           self.layer.borderWidth = borderWidth
        }
    }
    
    // радиус угла 
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
