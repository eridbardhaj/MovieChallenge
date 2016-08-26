//
//  PopularMoviesTableViewCell.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/21/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {
    // Constants
    static let cellIdentifier = String(PopularMoviesTableViewCell.self)
    
    // Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var certificationLabel: CustomLabel!
    @IBOutlet weak var yearReleasedLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Clear any design made on IB
        updateEmptyUI()
    }
    
    // MARK: - Configuration
    
    func updateUI(model: Movie?) {
        guard let model = model else {
            updateEmptyUI()
            
            return
        }
        
        clearOptionalValues(model)
        movieOverview.text = model.overview
        
        if let imageUrlString = model.posterImgUrlString,
            let posterImgURL = NSURL(string: imageUrlString) {
            posterImageView.setImageUrlAnimated(posterImgURL)
        }
    }
    
    
    // MARK: - Helpers
    
    private func updateEmptyUI() {
        movieTitleLabel.text = ""
        movieOverview.text = ""
        certificationLabel.text = "N/A"
        yearReleasedLabel.text = ""
        averageRatingLabel.text = ""
        voteCountLabel.text = "0"
    }
    
    private func clearOptionalValues(model: Movie) {
        if let title = model.title {
            self.movieTitleLabel.text = title
        }
        
        if let cerfification = model.certification {
            self.certificationLabel.text = cerfification
        }
        
        if let year = model.year {
            self.yearReleasedLabel.text = String(year)
        }
        
        if let rating = model.rating {
            self.averageRatingLabel.text = String(format: "%.1f", rating)
        }
        
        if let votes = model.votes {
            self.voteCountLabel.text = String(votes)
        }
    }
}
