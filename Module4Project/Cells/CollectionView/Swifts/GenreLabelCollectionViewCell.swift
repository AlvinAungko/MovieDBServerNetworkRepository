//
//  GenreLabelCollectionViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit

class GenreLabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreBackgroundView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    var GenreTypeData:GenreList?
    {
        didSet
        {
            if let data = GenreTypeData
            {
                genreLabel.text = data.name 
                if data.isSelected == true
                {
                    bottomView.isHidden = false
                } else {
                    
                    bottomView.isHidden = true
                }
            }
        }
    }
    
    var onTapGenreType:(String,Int)->Void = { _,_ in}
    
    public var dataToBind:DummyGenreLabel?
    {
        didSet
        {
            if let data = dataToBind
            {
                genreLabel.text = data.labelText
            
                (data.viewToHide) ? (bottomView.isHidden = true):(bottomView.isHidden = false) //tertiary operator
            }
        }
    }
    
    var onTabGenre : (String) -> Void = {
        _ in
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        makeItRound()
        addGesture()
    }

}

extension GenreLabelCollectionViewCell
{
    private func makeItRound()
    {
        genreBackgroundView.clipsToBounds = true
        genreBackgroundView.layer.cornerRadius = 12
    }
    
    @objc func onTabView()
    {
        onTapGenreType(GenreTypeData?.name ?? "",GenreTypeData?.id ?? 0)
    }
    
    private func addGesture()
    {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTabView))
        genreBackgroundView.isUserInteractionEnabled = true
        genreBackgroundView.addGestureRecognizer(gestureRecognizer)
    }
    

    
    
}
