//
//  ReviewsListViewController.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 25/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TourReviewsListViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var sortByButton: UIButton!
    @IBOutlet private weak var sortDirectionButton: UIButton!
    @IBOutlet private weak var ratingFilterButton: UIButton!
    
    private let viewModel = TourReviewsListViewModel()
    private var listLoader: TourReviewsListLoader!
    private var sectionManager: TourReviewsListSectionManager!
    private var scrollTriggerAdapter: ScrollViewBottomScrollTriggerAdapter!
    private let disposeBag = DisposeBag()
    
    convenience init() {
        self.init(nibName: "TourReviewsListViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        self.title = "RatingsTitle".localized
        
        self.listLoader = TourReviewsListLoader(viewModel: viewModel)
        self.sectionManager = TourReviewsListSectionManager(viewModel: viewModel, collectionView: collectionView)
        self.scrollTriggerAdapter = ScrollViewBottomScrollTriggerAdapter.init(scrollView: collectionView)
        
        setupUIObservations()
        setupModelObservations()
    }
    
    private func setupUIObservations() {
        self.scrollTriggerAdapter.bottomScrolledSignal.bind(to: viewModel.loadNextBatchSignal).disposed(by: disposeBag)
    }
    
    private func setupModelObservations() {
        viewModel.sortByPreset.subscribe(onNext: { [weak self] (sortBy) in
            self!.sortByButton.setTitle(sortBy.displayName(), for: .normal)
        }).disposed(by: disposeBag)
        
        viewModel.sortDirection.subscribe(onNext: { [weak self] (sortDirection) in
            self!.sortDirectionButton.setTitle(sortDirection.displayName(), for: .normal)
        }).disposed(by: disposeBag)
        
        viewModel.ratingFilter.subscribe(onNext: { [weak self] (filter) in
            self!.ratingFilterButton.setTitle(TourReviewsRatingFilterTitleGenerator.titleFor(ratingFilter: filter), for: .normal)
        }).disposed(by: disposeBag)
    }
}
