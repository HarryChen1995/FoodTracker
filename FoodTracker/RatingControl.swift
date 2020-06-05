//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Hanlin Chen on 5/22/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet{
         updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize:CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount:Int = 5 {
        didSet{
            setupButtons()
        }
    }
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder:coder)
        setupButtons()
    }
    // MARK: Private Method
    private func setupButtons(){
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // load button images
        let bundle = Bundle(for: type(of:self))
        let filledStar = UIImage(named:"filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith:  self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        for index in 0..<starCount {
            // createButton
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            // set the accessibility label
            button.accessibilityLabel = "Set \(index+1) star rating"
            //Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            // Add the button to Subview
            addArrangedSubview(button)
            // add button to ratingButtons Array
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    // Button Action
    @objc func ratingButtonTapped(button:UIButton){
        if let index = ratingButtons.firstIndex(of: button){
        
        let selectedRating = index + 1
        
        if selectedRating == rating{
            rating  = 0
        }else{
            rating = selectedRating
        }
        }
        else{
            fatalError("button not exist")
        }
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1{
                hintString = "Tap to reset the rating to zero"
            }
            else{
                hintString = nil
            }
            // Calculate the value string
            let valueString: String
            switch rating{
            case 0:
                valueString = "No Rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set."
            }
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
