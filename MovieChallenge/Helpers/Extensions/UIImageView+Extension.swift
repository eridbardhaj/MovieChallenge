//
//  UIImageView+Extension.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/21/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImageUrlAnimated(url: NSURL) {
        
        SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions.AllowInvalidSSLCertificates, progress: nil) { (image, _, _, _, _) in
            dispatch_async(dispatch_get_main_queue(), {
                self.alpha = 0
                UIView.animateWithDuration(0.2) { [weak self] in
                    self?.image = image
                    self?.alpha = 1
                }
            })
        }
        
    }
}