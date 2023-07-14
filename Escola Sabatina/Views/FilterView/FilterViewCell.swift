//
//  FilterViewCell.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 23/06/23.
//

import Foundation
import UIKit

class FilterViewCell: UICollectionViewCell {
    static let indentifier =  "idFilterViewCell"
        
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            if !newValue {
                setUnSelectedCell()
            } else {
                setSelectedCell()
            }
            super.isSelected = newValue
        }
    }
    
    var quarterlyGroup: QuarterlyGroup?
    var content = UIView()
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterViewCell {
    func initialSetup() {
        content.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
    }
    
    func layout() {
        content.addSubview(label)
        addSubview(content)
 
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: topAnchor),
            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor),
            content.bottomAnchor.constraint(equalTo: bottomAnchor),
            content.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: content.topAnchor, multiplier: 1),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: content.leadingAnchor, multiplier: 1.5),
            content.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 1.5),
            content.bottomAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 1)
        ])
    }
}

extension FilterViewCell {
    private func setSelectedCell() {
        label.textColor = .white
        content.backgroundColor = R.color.primaryColor()
        content.layer.cornerRadius = 34 / 2
    }
    
    private func setUnSelectedCell() {
        label.textColor = .gray
        content.backgroundColor = .none
    }
}
