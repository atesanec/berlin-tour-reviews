//
//  TourReviewsRatingFilterTitleGenerator.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 26/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation

class TourReviewsRatingFilterTitleGenerator {
    static func titleFor(ratingFilter: Int?) -> String {
        if let value = ratingFilter {
            return String(repeating: "⭐", count: value)
        }
        
        return "AllRatings".localized
    }
}
