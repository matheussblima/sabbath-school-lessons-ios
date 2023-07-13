//
//  StretchyTabelHeaderView.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 13/07/23.
//

import Foundation
import UIKit

class StretchyTabelHeaderView: UIView {
    let image = UIImageView()
    let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StretchyTabelHeaderView {
    private func initialSetup() {
        container.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
    }
    
    private func layout() {
        container.addSubview(image)
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: widthAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
