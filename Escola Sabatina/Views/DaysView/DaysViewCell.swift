//
//  DaysViewCell.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation
import UIKit

class DaysViewCell: UICollectionViewCell {
    static let indentifier =  "idDaysViewCell"
        
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

extension DaysViewCell {
    func initialSetup() {
        content.translatesAutoresizingMaskIntoConstraints = false
        content.layer.cornerRadius = 40 / 2
        content.clipsToBounds = true
        content.backgroundColor = R.color.grayDark()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        
    }
    
    func layout() {
        content.addSubview(label)
        addSubview(content)
 
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: topAnchor),
            content.widthAnchor.constraint(equalToConstant: 40),
            content.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: content.centerYAnchor)
        ])
    }
}

extension DaysViewCell {
    private func setSelectedCell() {
        content.backgroundColor = R.color.primaryColor()
    }
    
    private func setUnSelectedCell() {
        content.backgroundColor = R.color.grayDark()
    }
}
