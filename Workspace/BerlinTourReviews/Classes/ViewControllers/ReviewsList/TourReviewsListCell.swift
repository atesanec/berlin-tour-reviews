//
//  TourReviewsListCell.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 26/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import UIKit

class TourReviewsListCell: UICollectionViewCell {
    private static let labelHeight: CGFloat = 20.0
    private static let separatorHeight: CGFloat = 1.0
    private static var dateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter
    }
    
    private let authorLabel = UILabel()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let ratingLabel = UILabel()
    private let dateLabel = UILabel()
    private let separator = UIView()
    
    static let messageLabelFont = UIFont.systemFont(ofSize: 14)
    static let headerLabelFont = UIFont.boldSystemFont(ofSize: 12)
    static let minimalCellHeight : CGFloat = 40.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func configure(item: TourReviewEntity) {
        authorLabel.text = item.authorName
        titleLabel.text = item.title
        messageLabel.text = item.reviewText
        ratingLabel.text = String(repeating: "⭐", count: Int(item.rating))
        dateLabel.text = TourReviewsListCell.dateFormatter.string(from: item.creationDate)
    }
    
    private func setup() {
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(messageLabel)
        self.contentView.addSubview(ratingLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(separator)
        
        separator.backgroundColor = UIColor.lightGray
        
        messageLabel.font = TourReviewsListCell.messageLabelFont
        messageLabel.numberOfLines = 0
        
        authorLabel.font = TourReviewsListCell.headerLabelFont
        titleLabel.font = TourReviewsListCell.headerLabelFont
        ratingLabel.font = TourReviewsListCell.headerLabelFont
        
        dateLabel.font = TourReviewsListCell.headerLabelFont
        dateLabel.textAlignment = .right
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let containerBounds = self.contentView.bounds
        separator.frame = CGRect(x: 0, y: 0, width: containerBounds.width, height: TourReviewsListCell.separatorHeight)
        
        authorLabel.frame = CGRect(x: 0, y: 0, width: containerBounds.width, height: TourReviewsListCell.labelHeight)
        titleLabel.frame = CGRect(x: 0, y: self.authorLabel.frame.maxY, width: containerBounds.width, height: TourReviewsListCell.labelHeight)
        
        let ratingFrame = CGRect(x: 0, y: containerBounds.height - TourReviewsListCell.labelHeight,
                                 width: containerBounds.width * 0.5, height: TourReviewsListCell.labelHeight)
        ratingLabel.frame = ratingFrame
        
        var dateFrame = ratingFrame
        dateFrame.origin.x = ratingFrame.maxX
        self.dateLabel.frame = dateFrame
        
        let messageFrame = CGRect(x: 0, y: titleLabel.frame.maxY, width: containerBounds.width, height: dateFrame.minY - titleLabel.frame.maxY)
        messageLabel.frame = messageFrame
    }
}
