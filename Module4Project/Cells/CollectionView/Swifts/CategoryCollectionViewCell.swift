//
//  CategoryCollectionViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 12/02/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    var genreCategory:Genre?
    {
        didSet
        {
            if let data = genreCategory
            {
                cellLabel.text = data.name ?? ""
            }
        }
    }
    
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundLabel()
        // Initialization code
    }

}

extension CategoryCollectionViewCell
{
    private func roundLabel()
    {
        cellLabel.clipsToBounds = true
        cellLabel.layer.cornerRadius = 9
    }
}
