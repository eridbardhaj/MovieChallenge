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
        
        movieTitleLabel.text = model.title
        movieOverview.text = model.overview
        certificationLabel.text = model.certification
        yearReleasedLabel.text = String(model.year)
        averageRatingLabel.text = String(format: "%.1f", model.rating)
        voteCountLabel.text = String(model.votes)
        
        
        if let imageUrlString = model.posterImgUrlString,
            let posterImgURL = NSURL(string: imageUrlString) {
            posterImageView.setImageUrlAnimated(posterImgURL)
        }
    }
    
    private func updateEmptyUI() {
        movieTitleLabel.text = "N/A"
        movieOverview.text = ""
        certificationLabel.text = "N/A"
        yearReleasedLabel.text = "N/A"
        averageRatingLabel.text = "N/A"
        voteCountLabel.text = "0"
    }
}
