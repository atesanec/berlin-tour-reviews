//
//  TourReviewsListDataSource.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 26/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TourReviewsListSectionManager {
    let viewModel: TourReviewsListViewModel
    let disposeBag = DisposeBag()
    weak var collectionView: UICollectionView!
    
    init(viewModel: TourReviewsListViewModel, collectionView: UICollectionView) {
        self.viewModel = viewModel
        self.collectionView = collectionView
        self.configureManager()
    }
    
    private func configureManager() {
    }
    
    private func configuredCell(indexPath: IndexPath, item: TourReviewEntity) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
