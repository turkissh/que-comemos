//
//  RatingControl.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 10/17/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    //MARK: Properties
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    let filledStarImg = UIImage(named :"filledStar")
    let emptyStarImg = UIImage(named :"emptyStar")
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createButtons()
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonState()
    }
    
    
    
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton){
        rating = ratingButtons.index(of: button)! + 1
        updateButtonState()
    }
    
    func createButtons(){
        for _ in 0..<starCount {
            //Creates a button and adds color
            let button = UIButton()
            
            //Add button image on state
            button.setImage(#imageLiteral(resourceName: "emptyStar"), for: .normal)
            button.setImage(#imageLiteral(resourceName: "filledStar"), for: .selected)
            button.setImage(#imageLiteral(resourceName: "filledStar"), for: [.highlighted, .selected])
            
            button.adjustsImageWhenHighlighted = false
            
            //Adds action to button
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
            
            
            ratingButtons += [button]
            addSubview(button)
        }
    }

    func updateButtonState(){
        for (index,button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }
    
}
