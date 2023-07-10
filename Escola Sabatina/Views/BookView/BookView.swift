//
//  FilterView.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 23/06/23.
//

import Foundation
import UIKit

class BookView: UIView {
    
    var collectionView: UICollectionView
    
    init() {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .vertical
        layoutFlow.estimatedItemSize = CGSize(width: 1, height: 1)
        layoutFlow.minimumInteritemSpacing = 10
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

extension BookView {
    private func initialSetup() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
    }
    private func layout() {
        addSubview(collectionView)

        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
