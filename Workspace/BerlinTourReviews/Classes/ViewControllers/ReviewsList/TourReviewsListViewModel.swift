//
//  TourReviewsListViewModel.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 25/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import RxSwift

class TourReviewsListViewModel {
    let sortByPreset = BehaviorSubject<TourReviewNetworkService.SortType>(value: .dateCreated)
    let sortDirection = BehaviorSubject<TourReviewNetworkService.SortDirection>(value: .ascending)
    let ratingFilter = BehaviorSubject<Int?>(value: nil)
    let loadedReviews = BehaviorSubject<[TourReviewEntity]>(value: [TourReviewEntity]())
    
    let loadNextBatchSignal = PublishSubject<Void>()
}
