//
//  FilterView.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 23/06/23.
//

import Foundation
import UIKit

class FilterView: UIView {
    
    var collectionView: UICollectionView
    
    init() {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .horizontal
        layoutFlow.estimatedItemSize = CGSize(width: 100, height: 34)
        layoutFlow.minimumInteritemSpacing = 0
        layoutFlow.minimumLineSpacing = 0
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        
        super.init(frame: .zero)
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterView {
    private func initialSetup() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    private func layout() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 34)

        ])
    }
}
