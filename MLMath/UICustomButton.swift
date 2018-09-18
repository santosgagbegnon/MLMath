//
//  UIRoundableButton.swift
//  Daily Drop
//
//  Created by Santos on 2018-06-15.
//  Copyright © 2018 Santos. All rights reserved.
//

import UIKit
@IBDesignable class UICustomButton: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
        
    }
    
    @IBInspectable var borderColor : UIColor?  =  UIColor.black {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
        
    }
    
    
   
}
