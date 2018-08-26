//
//  ScrollViewBottomScrollTriggerAdapter.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 26/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

/**
 *  Triggers action when collection view scrolled to bottom
 */
class ScrollViewBottomScrollTriggerAdapter: NSObject, UIScrollViewDelegate {
    let bottomScrolledSignal = PublishSubject<Void>()
    
    private static let triggerDistance: CGFloat = 100.0
    private weak var scrollView: UIScrollView!
    private let disposeBag = DisposeBag()
    
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init()
        self.scrollView.rx.didScroll.subscribe(onNext: { [weak self] _ in
            if !scrollView.isDragging && !scrollView.isTracking && !scrollView.isDecelerating {
                return
            }
            
            let offsetY = scrollView.contentOffset.y
            let maxOffsetY = scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom
            
            if maxOffsetY - offsetY < ScrollViewBottomScrollTriggerAdapter.triggerDistance {
                self!.bottomScrolledSignal.onNext(())
            }
        }).disposed(by: disposeBag)
    }

}
