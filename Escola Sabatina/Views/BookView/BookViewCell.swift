//
//  BookView.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 07/07/23.
//

import Foundation
import UIKit


protocol BookViewCellDelegate: AnyObject {
    func didCellTapped(cell: BookViewCell, quarterly: Quarterly?)
}

class BookViewCell: UICollectionViewCell {
    static let identifier = "idBookViewCell"
    
    let bookCoverImage = UIImageView()
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    var quarterly: Quarterly?
    let content = UIView()
    
    weak var delegate: BookViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookViewCell {
    private func initialSetup() {
        content.translatesAutoresizingMaskIntoConstraints = false
        
        bookCoverImage.translatesAutoresizingMaskIntoConstraints = false
        bookCoverImage.layer.cornerRadius = 4
        bookCoverImage.layer.masksToBounds = true
        bookCoverImage.clipsToBounds = true
        bookCoverImage.contentMode = .scaleToFill
        bookCoverImage.isUserInteractionEnabled = true
        bookCoverImage.addGestureRecognizer(tapGestureRecognizer)
        
        tapGestureRecognizer.addTarget(self, action: #selector(imageTapped))
        
        content.layer.shadowColor = UIColor.gray.cgColor
        content.layer.shadowRadius = 4.0
        content.layer.shadowOpacity = 0.2
        content.layer.shadowOffset = CGSize(width: 0, height: 4)
        content.layer.masksToBounds = false
       
    }
    
    private func layout() {
        addSubview(content)
        content.addSubview(bookCoverImage)
    
        NSLayoutConstraint.activate([
            bookCoverImage.topAnchor.constraint(equalTo: content.topAnchor),
            bookCoverImage.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            bookCoverImage.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            bookCoverImage.bottomAnchor.constraint(equalTo: content.bottomAnchor),
        ])
    }
}

extension BookViewCell {
    @objc func imageTapped() {
        bookCoverImage.alpha = 0.75
        UIView.animate(withDuration: 0.5) {
            self.bookCoverImage.alpha = 1.0
        }
        delegate?.didCellTapped(cell: self, quarterly: quarterly)
    }
}
