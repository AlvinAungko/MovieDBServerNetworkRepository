//
//  CreatorAndCompanyCollectionViewCell.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 17/03/2022.
//

import UIKit
import SDWebImage

class CreatorAndCompanyCollectionViewCell: UICollectionViewCell
{
    
    var creator:CreatedBy?
    {
        didSet
        {
            if let data = creator
            {
                imageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.profilePath ?? "")"))
                titleLabel.text = data.name ?? ""
            }
        }
    }
    
    
    var productionCompany:ProductionCompany?
    {
        didSet {
            if let data = productionCompany
            {
                imageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.logoPath ?? "")"))
                
                titleLabel.text = data.name ?? ""
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


