//
//  TrailerVideoCollectionViewCell.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 18/03/2022.
//

import UIKit
import YouTubePlayer



class TrailerVideoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var youtubeVideoView: YouTubePlayerView!
    
    
    // Data Bind
    
    var filmTrailer:Trailer?
    {
        didSet
        {
            if let data = filmTrailer
            {
                receiveTrailer(trailer: data)
            }
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        addGesture()
       
    }
    
}

extension TrailerVideoCollectionViewCell
{
    
    func receiveTrailer(trailer:Trailer)
    {
        let youTubeIDKey = trailer.key ?? ""
        let youTubeVideoUrl = "\(AppConstants.baseYoutubeUrl)=\(youTubeIDKey)"
       
        guard let url = URL(string: youTubeVideoUrl) else {return}
        
        youtubeVideoView.loadVideoURL(url)
        youtubeVideoView.play()
    }
    

}


