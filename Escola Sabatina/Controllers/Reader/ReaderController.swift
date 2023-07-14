//
//  ReaderController.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation
import UIKit

class ReaderController: UIViewController {
    
    var days = [Day]()
    
    let lesson: Lesson
    let idQuartely: String
    let languageCode: String
    let dayViewModel = DayViewModel()
   
    let daysView = DaysView()
    
    init(lesson: Lesson, idQuartely: String, languageCode: String) {
        self.lesson = lesson
        self.idQuartely = idQuartely
        self.languageCode = languageCode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        layout()
        setupNavigation()
    }
}

extension ReaderController {
    private func initialSetup() {
        view.backgroundColor = .white
        
        dayViewModel.add(delegate: self)
        dayViewModel.getDays(idQuartely: idQuartely, languageCode: languageCode, idLesson: lesson.id)
        
        daysView.translatesAutoresizingMaskIntoConstraints = false
        daysView.collectionView.dataSource = self
        daysView.collectionView.register(DaysViewCell.self, forCellWithReuseIdentifier: DaysViewCell.indentifier)
    }
    
    private func layout() {
        view.addSubview(daysView)
        
        NSLayoutConstraint.activate([
            daysView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            daysView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            daysView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupNavigation() {
        print(lesson.title)
        title = lesson.title
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension ReaderController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysViewCell.indentifier, for: indexPath) as! DaysViewCell
        
        let data = days[indexPath.row]
        print("===> \(data)")
        cell.label.text = data.date
        
        return cell
    }
    
    
}

extension ReaderController: DayViewModelDelegate {
    func didGetDays(_ days: [Day]?, error: DataError?) {
        if let days = days {
            self.days = days
            daysView.collectionView.reloadData()
        }
    }
}
