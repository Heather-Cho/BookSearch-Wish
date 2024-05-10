//
//  CartCollectionViewCell.swift
//  0508
//
//  Created by t2023-m0114 on 5/9/24.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CartCollectionViewCell"
    
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(imageView)
            imageView.frame = bounds
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            imageView.frame = bounds
        }
}
