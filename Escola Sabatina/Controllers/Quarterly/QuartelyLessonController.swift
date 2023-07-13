//
//  QuartelyLessonController.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 10/07/23.
//

import Foundation
import SDWebImage
import UIKit

class QuartelyLessonController: UIViewController {
    
    var bookView = BookView()
    var quarterlies = [Quarterly]()
    
    override func viewDidLoad() {
        initialSetup()
        layout()
    }
}

extension QuartelyLessonController {
    private func initialSetup() {
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
        return quarterlies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookViewCell.identifier, for: indexPath) as! BookViewCell
        
        cell.delegate = self
        
        let widthItem = (view.frame.width - 12) / 2
        let heightItem: CGFloat = 220
        
        NSLayoutConstraint.activate([
            cell.content.widthAnchor.constraint(lessThanOrEqualToConstant: widthItem),
            cell.content.heightAnchor.constraint(lessThanOrEqualToConstant: heightItem)
        ])
        
        if !quarterlies.isEmpty {
            let data = quarterlies[indexPath.item]
            cell.bookCoverImage.sd_setImage(with: data.cover)
            cell.quarterly = data
        }

        return cell
        
    }
}

extension QuartelyLessonController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthItem = (view.frame.width - 12) / 2
        let heightItem: CGFloat = 220
        
        return CGSize.init(width: widthItem, height: heightItem)
    }
}

extension QuartelyLessonController: QuarterlyViewModelDelegate {
    func didGetQuarterlies(_ quarterlyViewModel: QuarterlyViewModel, error: DataError?) {}
    
    func didSelectedQuarterly(_ quarterlyViewModel: QuarterlyViewModel) {
        quarterlies = quarterlyViewModel.quarterlies.filter {
            $0.quarterlyGroup?.name == quarterlyViewModel.selectedQuarterly?.name
        }
        bookView.collectionView.reloadData()
    }
}

extension QuartelyLessonController: BookViewCellDelegate {
    func didCellTapped(cell: BookViewCell, quarterly: Quarterly) {
        navigationController?.pushViewController(LessonController(quarterly: quarterly), animated: true)
    }
}
