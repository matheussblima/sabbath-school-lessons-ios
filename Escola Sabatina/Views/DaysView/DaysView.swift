//
//  DaysView.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation
import UIKit

class DaysView: UIView {
    
    let container = UIView()
    let label = UILabel()
    let collectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .horizontal
        layoutFlow.estimatedItemSize = CGSize(width: 50, height: 90)
        layoutFlow.minimumInteritemSpacing = 0
        layoutFlow.minimumLineSpacing = 0
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        
        super.init(frame: frame)
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DaysView {
    private func initialSetup() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = R.color.grayColor()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Coisas da vida"
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func layout() {
        container.addSubview(label)
        container.addSubview(collectionView)
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: container.topAnchor, multiplier: 1),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 1),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
