//
//  RRInsetLabel.swift
//  ChimeSNS
//
//  Created by chunlei.sun on 2023/4/20.
//

import UIKit

class RRInsetLabel: UILabel {
       @objc var textInsets = UIEdgeInsets.zero
    
       override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
           guard text != nil else {
               return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
           }
           
           let insetRect = bounds.inset(by: textInsets)
           let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
           let invertedInsets = UIEdgeInsets(top:       -textInsets.top,
                                             left:      -textInsets.left,
                                             bottom:    -textInsets.bottom,
                                             right:     -textInsets.right)
           return textRect.inset(by: invertedInsets)
       }
       
       override func drawText(in rect: CGRect) {
           super.drawText(in: rect.inset(by: textInsets))
       }
}

@IBDesignable
extension RRInsetLabel {
    @IBInspectable
    var leftTextInset: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left}
    }
    
    @IBInspectable
    var rightTextInset: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right}
    }
    
    @IBInspectable
    var topTextInset: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top}
    }
    
    @IBInspectable
    var bottomTextInset: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom}
    }
}
