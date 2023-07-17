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
    let content = UIView()
    let labelDay = UILabel()
    let labelDayName = UILabel()
    
    
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
        
        labelDayName.translatesAutoresizingMaskIntoConstraints = false
        labelDayName.font = UIFont.boldSystemFont(ofSize: 16)
        labelDayName.textColor = R.color.grayDark()

        labelDay.translatesAutoresizingMaskIntoConstraints = false
        labelDay.font = UIFont.boldSystemFont(ofSize: 14)
        labelDay.textColor = .white
        
    }
    
    func layout() {
        content.addSubview(labelDay)
        addSubview(labelDayName)
        addSubview(content)
 
        NSLayoutConstraint.activate([
            labelDayName.topAnchor.constraint(equalTo: topAnchor),
            labelDayName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalToSystemSpacingBelow: labelDayName.bottomAnchor, multiplier: 1),
            content.centerXAnchor.constraint(equalTo: centerXAnchor),
            content.widthAnchor.constraint(equalToConstant: 40),
            content.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            labelDay.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            labelDay.centerYAnchor.constraint(equalTo: content.centerYAnchor)
        ])
    }
}

extension DaysViewCell {
    private func setSelectedCell() {
        content.backgroundColor = R.color.primaryColor()
        labelDayName.textColor = R.color.primaryColor()
    }
    
    private func setUnSelectedCell() {
        content.backgroundColor = R.color.grayDark()
        labelDayName.textColor = R.color.grayDark()
    }
}
