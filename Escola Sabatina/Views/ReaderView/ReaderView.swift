//
//  ReaderView.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 18/07/23.
//

import Foundation
import UIKit
import WebKit

class ReaderView: UIView {
    let webView = WKWebView()
    
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
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .white
    }
    
    private func layout() {
        addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

