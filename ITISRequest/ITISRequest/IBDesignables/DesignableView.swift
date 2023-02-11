//
//  DesignableView.swift
//  ITISRequest
//
//  Created by Эльмира Байгулова on 22.05.2022.
//

import UIKit
import Foundation

@IBDesignable
class DesignableView: UIButton {

    // радиус угла кнопки
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    // цвет рамки кнопки
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
           self.layer.borderColor = borderColor.cgColor
        }
    }
    
    // ширина границы кнопки
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
           self.layer.borderWidth = borderWidth
        }
    }
    
    // цвет тени кнопки
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
       didSet{
           self.layer.shadowColor = shadowColor.cgColor
           self.layer.masksToBounds = false
       }
    }
    
    // непрозрачность тени кнопки
    @IBInspectable var shadowOpacity: Float = 0.4 {
       didSet {
          self.layer.masksToBounds = false
          self.layer.shadowOpacity = shadowOpacity
       }
    }
        
    // смещение тени кнопки
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 1, height: 4) {
        didSet {
           self.layer.masksToBounds = false
           self.layer.shadowOffset = shadowOffset
        }
    }
    
    // радиус тени кнопки
    @IBInspectable var shadowRadius: CGFloat = CGFloat(0.5) {
       didSet {
          self.layer.masksToBounds = false
          self.layer.shadowRadius = shadowRadius
       }
    }
    
    
    @IBInspectable var rotation: Double = 0 {
        didSet {
            rotateButton(rotation: rotation)
        }
    }

    func rotateButton(rotation: Double)  {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(.pi/2 + rotation))
    }

}

