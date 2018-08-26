//
//  TourReviewsListDataSectionItem.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 26/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import RxDataSources

extension TourReviewEntity: IdentifiableType {
    var identity: Int {
        return self.reviewId
    }
}

struct TourReviewsListDataSection {
    typealias Item = TourReviewEntity
    var items: [Item]
}

extension TourReviewsListDataSection: AnimatableSectionModelType {
    typealias Identity = String
    
    var identity: String {
        return "1"
    }
    
    init(original: TourReviewsListDataSection, items: [Item]) {
        self = original
        self.items = items
    }
}
