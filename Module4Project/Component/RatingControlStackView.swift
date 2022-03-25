//
//  RatingControlStackView.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit

@IBDesignable class RatingControlStackView: UIStackView
{
        
    
    @IBInspectable var rating: Int = 3
    {
        didSet
        {
            setUpButtons()
            updateButtonRating()
            }
    }
    
    @IBInspectable var starSize : CGSize = CGSize(width: 16, height: 16)
    {
        didSet
        {
            setUpButtons()
           
        }
    }
    
    @IBInspectable var starCount: Int = 5
    {
        didSet{
            
            setUpButtons()
           
        }
    }
    
    var buttonRating:Array<UIButton> = Array()
    
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        setUpButtons()
        updateButtonRating()
    }
    
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
        setUpButtons()
        updateButtonRating()
    }
    
    private func setUpButtons()
    {
        clearExistingButton()
        
        for _ in 0..<starCount
        {
            let button = UIButton()
            
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setImage(UIImage(named: "Empty Star"), for: .normal)
            button.setImage(UIImage(named: "Full Star"), for: .selected)
            
            button.isUserInteractionEnabled = false
            
            buttonRating.append(button)
            addArrangedSubview(button)
        }
       
    }
    
    private func updateButtonRating()
    {
        for (index,value) in buttonRating.enumerated()
        {
            if index < rating
            {
                value.isSelected = true
            } else {
                value.isSelected = false
            }
        }
    }
    
    private func clearExistingButton()
    {
        for button in buttonRating
        {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        buttonRating.removeAll()
    }

}
