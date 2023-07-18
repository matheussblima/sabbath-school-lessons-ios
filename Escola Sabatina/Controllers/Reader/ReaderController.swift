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
    let readViewModel = ReadViewModel()
   
    let lessonInfoView = LessonInfoView()
    let daysView = DaysView()
    let readerView = ReaderView()
    
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
        daysView.collectionView.delegate = self
        daysView.collectionView.register(DaysViewCell.self, forCellWithReuseIdentifier: DaysViewCell.indentifier)
        
        readViewModel.delegate = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        let dateStart: Date? = dateFormatter.date(from: lesson.startDate)
        let dateEnd: Date? = dateFormatter.date(from: lesson.endDate)
        
        if let dateStart = dateStart, let dateEnd = dateEnd {
            dateFormatter.dateFormat = "MMM dd"
            daysView.label.text = "\(dateFormatter.string(from: dateStart).capitalized) - \(dateFormatter.string(from: dateEnd).capitalized)"
        }
        
        lessonInfoView.translatesAutoresizingMaskIntoConstraints = false
        lessonInfoView.lessonTitle.text = lesson.title
        
        readerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(daysView)
        view.addSubview(lessonInfoView)
        view.addSubview(readerView)

        NSLayoutConstraint.activate([
            daysView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            daysView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            daysView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            daysView.heightAnchor.constraint(equalToConstant: 120)
        ])

        NSLayoutConstraint.activate([
            lessonInfoView.topAnchor.constraint(equalTo: daysView.bottomAnchor),
            lessonInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lessonInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            readerView.topAnchor.constraint(equalTo: lessonInfoView.bottomAnchor),
            readerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            readerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            readerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        title = lesson.title
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension ReaderController {
    func getRead(idDay: String) {
        readViewModel.getRead(idQuartely: idQuartely, languageCode: languageCode, idLesson: lesson.id, idDay: idDay)
    }
}

extension ReaderController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count > 7 ? 7 : days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysViewCell.indentifier, for: indexPath) as! DaysViewCell
        
        let data = days[indexPath.row]
        
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "dd/MM/yyyy"
        
        let date = dataFormatter.date(from: data.date)
        
        if let date = date {
            dataFormatter.dateFormat = "dd"
            cell.labelDay.text = dataFormatter.string(from: date)
            dataFormatter.dateFormat = "EEE"
            cell.labelDayName.text = dataFormatter.string(from: date).uppercased().replacingOccurrences(of: ".", with: "")
        }
        return cell
    }
}

extension ReaderController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width - 60) / 7
        return CGSize(width: size, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        getRead(idDay: day.id)
    }
}

extension ReaderController: DayViewModelDelegate {
    func didGetDays(_ days: [Day]?, error: DataError?) {
        if let days = days {
            self.days = days
            getRead(idDay: days[0].id)
            daysView.collectionView.reloadData()
            daysView.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        }
    }
}

extension ReaderController: ReadViewModelDelegate {
    func didGetRead(_ read: Read?, error: DataError?) {
        if let content = read?.content {
            readerView.setHtmlStringToLabel(htmlString: content)
        }
    }
}
