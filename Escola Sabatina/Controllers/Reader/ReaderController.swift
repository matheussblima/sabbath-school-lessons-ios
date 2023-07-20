//
//  ReaderController.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation
import UIKit
import WebKit

class ReaderController: UIViewController {
    
    var days = [Day]()
    
    let lesson: Lesson
    let idQuartely: String
    let languageCode: String
    let dayViewModel = DayViewModel()
    let readViewModel = ReadViewModel()
   
    let scroll = UIScrollView()
    let stack = UIStackView()
    let lessonInfoView = LessonInfoView()
    let daysView = DaysView()
    let readerView = ReaderView()
    
    var heightReaderView: NSLayoutConstraint?
    
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
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        
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
        readerView.webView.navigationDelegate = self
        readerView.webView.scrollView.isScrollEnabled = false
    }
    
    private func layout() {
        view.addSubview(daysView)
        view.addSubview(scroll)
        stack.addArrangedSubview(lessonInfoView)
        stack.addArrangedSubview(readerView)
        scroll.addSubview(stack)

        NSLayoutConstraint.activate([
            daysView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            daysView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            daysView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            daysView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: daysView.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        ])
        heightReaderView = readerView.heightAnchor.constraint(equalToConstant: 1)
        heightReaderView?.isActive = true
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
            if let day = days.first {
                getRead(idDay: day.id)
                daysView.collectionView.reloadData()
                daysView.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
            }
        }
    }
}

extension ReaderController: ReadViewModelDelegate {
    func didGetRead(_ read: Read?, error: DataError?) {
        if let content = read?.content {
            guard let filePath = Bundle.main.path(forResource: "index", ofType: "html") else {
                print("File not found")
                return
            }
    
            var htmlString = try? String(contentsOfFile: filePath, encoding: .utf8)
            htmlString = htmlString?.replacingOccurrences(of: "{{content}}", with: content)
            readerView.setHtmlStringToLabel(htmlString: htmlString ?? content)
        }
    }
}

extension ReaderController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.heightReaderView?.constant = 0
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.heightReaderView?.constant = webView.scrollView.contentSize.height
        }
    }
}
