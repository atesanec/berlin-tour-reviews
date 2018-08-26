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

@objc class TourReviewsListSectionManager: NSObject, UICollectionViewDelegateFlowLayout {
    private static let defaultCellIdentfier = "Cell"
    
    private let viewModel: TourReviewsListViewModel
    private let disposeBag = DisposeBag()
    private weak var collectionView: UICollectionView!
    private var calculateSizeObservable: Observable<[Any]>!
    
    init(viewModel: TourReviewsListViewModel, collectionView: UICollectionView) {
        self.viewModel = viewModel
        self.collectionView = collectionView
        super.init()
        self.configureManager()
    }
    
    private func configureManager() {
        let defaultCellId = TourReviewsListSectionManager.defaultCellIdentfier
        collectionView.register(TourReviewsListCell.self, forCellWithReuseIdentifier: defaultCellId)
        
        viewModel.loadedReviews.bind(to: collectionView.rx.items(cellIdentifier: defaultCellId, cellType: TourReviewsListCell.self)) { index, model, cell in
            cell.configure(item: model)
            }.disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item: TourReviewEntity = try! collectionView.rx.model(at: indexPath)
        let messageLabelHeight = ceil(item.reviewText.heightWithConstrainedWidth(width: collectionView.frame.width,
                                                                            font: TourReviewsListCell.messageLabelFont))
        
        return CGSize(width: collectionView.frame.width, height: messageLabelHeight + TourReviewsListCell.minimalCellHeight)
    }
}
