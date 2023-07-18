//
//  ReaderView.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 18/07/23.
//

import Foundation
import UIKit

class ReaderView: UIView {
    let htmlText = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReaderView {
    private func initialSetup() {

        htmlText.translatesAutoresizingMaskIntoConstraints = false
        htmlText.textColor = .black
    }
    
    private func layout() {
        addSubview(htmlText)
        
        NSLayoutConstraint.activate([
            htmlText.topAnchor.constraint(equalTo: topAnchor),
            htmlText.leadingAnchor.constraint(equalTo: leadingAnchor),
            htmlText.trailingAnchor.constraint(equalTo: trailingAnchor),
            htmlText.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ReaderView {
    func setHtmlStringToLabel(htmlString: String) {
        let data = htmlString.data(using: .utf8)

        if let data = data {
            htmlText.attributedText = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
    }
}

