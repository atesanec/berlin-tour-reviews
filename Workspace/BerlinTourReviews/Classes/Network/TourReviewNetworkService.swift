//
//  TourReviewNetworkService.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 24/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import RxSwift

/**
 *  Network service thata fetcher user reviews
 */
class TourReviewNetworkService {
    /**
     *  Results sort type
     */
    enum SortType : String {
        case dateCreated = "date_of_review"
        case rating
    }
    
    /**
     *  Results sort direction
     */
    enum SortDirection: String {
        case ascending = "ASC"
        case descending = "DESC"
    }
    
    private enum Params: String {
        case rating
        case sortBy
        case direction
    }
    
    private enum Paths: String {
        case reviewsJson = "reviews.json"
    }
    
    
    let mappingQueue = DispatchQueue(label: "com.supercorp.tourReviewNetworkService")
    let baseURL = URL(string: "https://www.getyourguide.com/berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776")!
    
    func tourReviewsPager(batchSize: Int, ratingFilter: Int?, sortBy: SortType, sortDirection: SortDirection) -> NetworkRequestOffsetPager<TourReviewEntity> {
        let params: [String: Any] = [
            Params.rating.rawValue: ratingFilter ?? 0,
            Params.sortBy.rawValue: sortBy.rawValue,
            Params.direction.rawValue: sortDirection.rawValue
        ]
        
        let path = baseURL.appendingPathComponent(Paths.reviewsJson.rawValue)
        
        let config = NetworkRequestOffsetPagerConfiguration(requestParameters: params,
                                                            pagingParamName: nil,
                                                            countParamName: nil,
                                                            batchSize: batchSize,
                                                            mappingHandler: {TourReviewEntity(fromJson: $0)},
                                                            mappingQueue: mappingQueue,
                                                            mappingObjectListRootPath: "data",
                                                            requestURL: path)
        return NetworkRequestOffsetPager(configuration: config)
    }
}
