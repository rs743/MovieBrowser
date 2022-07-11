//
//  MovieCell.swift
//  MovieBrowser
//
//  Created by Raveen Surabhi on 6/26/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            setUpCell()
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    private func setUpCell() {
        
        if let movie = movie {
            title.text = movie.title
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withYear,.withMonth,.withDay,.withDashSeparatorInDate]
            
            if let releaseDt = movie.releaseDate, let date = dateFormatter.date(from: releaseDt) {
                releaseTitleLabel.text = "Release Date : " + date.string(withFormat: "MM/dd/yy")
            } else {
                releaseTitleLabel.text = movie.releaseDate
            }
            ratingLabel.text = "\(movie.ratingScore)"
        }
    }
    
}
