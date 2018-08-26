//
//  TourReviewsListLoader.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 26/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import RxSwift

class TourReviewsListLoader {
    private static let batchSize = 10
    
    private let viewModel: TourReviewsListViewModel
    private let viewModelDisposeBag = DisposeBag()
    private var requestDisposeBag = DisposeBag()
    private let networkService = TourReviewNetworkService()
    private var pager: NetworkRequestOffsetPager<TourReviewEntity>!
    
    init(viewModel: TourReviewsListViewModel) {
        self.viewModel = viewModel
        self.setupObservations()
    }
    
    private func setupObservations() {
        viewModel.loadNextBatchSignal.subscribe(onNext: { [weak self] _ in
            let strongSelf = self!
            let isLoading = try! strongSelf.pager!.isLoading.value()
            if !isLoading {
                strongSelf.pager!.loadNext().subscribe().disposed(by: strongSelf.requestDisposeBag)
            }
        }).disposed(by: viewModelDisposeBag)
        
        Observable.combineLatest(viewModel.sortByPreset, viewModel.sortDirection, viewModel.ratingFilter)
            .subscribe(onNext: { [weak self] _ in
                let strongSelf = self!
                strongSelf.setupPager()
                strongSelf.viewModel.loadNextBatchSignal.onNext(())
        }).disposed(by: viewModelDisposeBag)
    }
    
    private func setupPager() {
        requestDisposeBag = DisposeBag()
        pager = networkService.tourReviewsPager(batchSize: TourReviewsListLoader.batchSize,
                                                ratingFilter: try! viewModel.ratingFilter.value(),
                                                sortBy: try! viewModel.sortByPreset.value(),
                                                sortDirection: try! viewModel.sortDirection.value())
        
        pager.loadedEntities.bind(to: viewModel.loadedReviews).disposed(by: viewModelDisposeBag)
    }
}
