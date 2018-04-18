//
//  EaterButton.swift
//  eater
//
//  Created by Emiliano Di Pierro on 17/04/2018.
//  Copyright © 2018 Emiliano Di Pierro. All rights reserved.
//

import Foundation
import UIKit

class EaterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setProperties()
    }
    
    private func setProperties() {
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont(name: "Roboto", size: 24)
        self.backgroundColor = Constants.Colors.greenButtonColor
        self.layer.cornerRadius = Constants.Buttons.borderRadius
        self.layer.borderWidth = Constants.Buttons.borderWidth
        self.layer.borderColor = UIColor.white.cgColor
    }
    
}
