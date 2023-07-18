//
//  LessonInfoView.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 18/07/23.
//

import Foundation
import UIKit

class LessonInfoView: UIView {
    let lessonTitle = UILabel()
    let title = UILabel()
    let subTitle = UILabel()
    let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LessonInfoView {
    private func initialSetup() {
        backgroundColor = .black
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        
        lessonTitle.translatesAutoresizingMaskIntoConstraints = false
        lessonTitle.textColor = .white
        lessonTitle.font = UIFont.boldSystemFont(ofSize: 16)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = R.color.yellow()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.text = "TEXTO-CHAVE"
        
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.textColor = .white
        subTitle.text = "LEIA O TEXTO BÍBLICO DESTA SEMANA:"
        subTitle.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func layout() {
        stack.addArrangedSubview(lessonTitle)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(subTitle)
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stack.bottomAnchor, multiplier: 2)
        ])
    }
}
