//
//  QuartelyLessonController.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 10/07/23.
//

import Foundation
import UIKit

class QuartelyLessonController: UIViewController {
    
    var bookView = BookView()
  
    override func viewDidLoad() {
        initialSetup()
        layout()
    }
}


extension QuartelyLessonController {
    private func initialSetup() {
        view.backgroundColor = .orange
        bookView.translatesAutoresizingMaskIntoConstraints = false
        bookView.collectionView.dataSource = self
        bookView.collectionView.delegate = self
        bookView.collectionView.register(BookViewCell.self, forCellWithReuseIdentifier: BookViewCell.identifier)
    }
    
    private func layout() {
        view.addSubview(bookView)
        
        NSLayoutConstraint.activate([
            bookView.topAnchor.constraint(equalTo: view.topAnchor),
            bookView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension QuartelyLessonController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookViewCell.identifier, for: indexPath) as! BookViewCell
        
       let widthItem = (view.frame.width - 12) / 2
        let heightItem: CGFloat = 200
        
        NSLayoutConstraint.activate([
            cell.content.widthAnchor.constraint(lessThanOrEqualToConstant: widthItem),
            cell.content.heightAnchor.constraint(lessThanOrEqualToConstant: heightItem)
        ])
    
        guard let fileUrl = URL(string: "https://sabbath-school-stage.adventech.io/api/v2/en/quarterlies/2023-03/cover.png") else {
            return UICollectionViewCell()
        }
        
        
        cell.bookCoverImage.imageFrom(url: fileUrl)
        
        return cell
        
    }
}

extension QuartelyLessonController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthItem = (view.frame.width - 12) / 2
        let heightItem: CGFloat = 200
        
        return CGSize.init(width: widthItem, height: heightItem)
    }
}
