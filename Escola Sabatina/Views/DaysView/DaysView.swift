//
//  DaysView.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation
import UIKit

class DaysView: UIView {
    
    var collectionView: UICollectionView
    var label = UILabel()
    
    init() {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .horizontal
        layoutFlow.estimatedItemSize = CGSize(width: 40, height: 40)
        layoutFlow.minimumInteritemSpacing = 0
        layoutFlow.minimumLineSpacing = 10
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        
        super.init(frame: .zero)
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DaysView {
    private func initialSetup() {
        backgroundColor = R.color.grayColor()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = R.color.grayColor()
     
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = R.color.grayDark()

    }
    private func layout() {
        addSubview(label)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
