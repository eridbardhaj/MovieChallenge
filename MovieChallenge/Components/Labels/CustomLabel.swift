//
//  CustomLabel.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/21/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class CustomLabel: UILabel {
    
    // MARK: - Inspectables
    
    @IBInspectable var cornerRadius: CGFloat = 2.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = Style.Colors.gray {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
