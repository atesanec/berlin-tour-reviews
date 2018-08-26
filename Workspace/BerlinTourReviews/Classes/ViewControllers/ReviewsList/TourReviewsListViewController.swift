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
    
    convenience init() {
        self.init(nibName: "TourReviewsListViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        self.listLoader = TourReviewsListLoader(viewModel: viewModel)
        
        setupUIObservations()
        setupModelObservations()
    }
    
    private func setupUIObservations() {
        
    }
    
    private func setupModelObservations() {
        
    }
}
