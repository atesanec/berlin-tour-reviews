//
//  TourReviewResponseItem.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 25/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation

/**
 *  Tour Review
 */
class TourReviewEntity: Equatable {
    static var dateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter
    }
    
    let reviewId: Int
    let authorName: String
    let title : String
    let reviewText : String
    let creationDate : Date
    let languageCode : String
    let rating: Double
    
    init(fromJson: Any) {
        let jsonDict = fromJson as! [String: Any]
        self.reviewId = jsonDict.valueFor(keyPath: "review_id") as! Int
        self.authorName = jsonDict.valueFor(keyPath: "author") as! String
        self.title = jsonDict.valueFor(keyPath: "title") as! String
        self.reviewText = jsonDict.valueFor(keyPath: "message") as! String
        self.creationDate = TourReviewEntity.dateFormatter.date(from: jsonDict.valueFor(keyPath: "date") as! String)!
        self.languageCode = jsonDict.valueFor(keyPath: "languageCode") as! String
        self.rating = Double(jsonDict.valueFor(keyPath: "rating") as! String)!
    }
    
    static func == (left: TourReviewEntity, right: TourReviewEntity) -> Bool {
        return left.reviewId == right.reviewId
    }
}


