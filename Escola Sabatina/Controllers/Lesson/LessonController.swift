//
//  LessonController.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 13/07/23.
//

import Foundation
import UIKit
import SDWebImage

class LessonController: UIViewController {
    static let identifier = "idLessonTabelView"
    var lessons = [Lesson]()
    let header = StretchyTabelHeaderView()
    let tabelView = UITableView()
    let quarterly: Quarterly
    let lessonViewModel = LessonViewModel()
    
    
    init(quarterly: Quarterly) {
        self.quarterly = quarterly
        
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

extension LessonController {
    private func initialSetup() {
        view.backgroundColor = .white
        
        lessonViewModel.getLessons(idQuartely: quarterly.id, languageCode: quarterly.lang)
        lessonViewModel.add(delegate: self)
        
        tabelView.translatesAutoresizingMaskIntoConstraints = false
       
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(UITableViewCell.self, forCellReuseIdentifier: LessonController.identifier)
        
        header.translatesAutoresizingMaskIntoConstraints = false
  
    }
    
    private func layout() {
        view.addSubview(tabelView)
        
        if let splash = quarterly.splash {
            header.image.sd_setImage(with: splash)
            tabelView.tableHeaderView = header
            
            NSLayoutConstraint.activate([
                header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                header.heightAnchor.constraint(equalToConstant: 400)
            ])
        }
        
        NSLayoutConstraint.activate([
            tabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
    private func setupNavigation() {
        title = quarterly.title
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension LessonController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonController.identifier, for: indexPath)
        
        let data = lessons[indexPath.row]
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = data.title
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"

        let dateStart: Date? = dateFormatterGet.date(from: data.startDate)
        let dateEnd: Date? = dateFormatterGet.date(from: data.endDate)
        
        if let dateStart = dateStart, let dateEnd = dateEnd {
            configuration.secondaryText = "\(dateFormatter.string(from: dateStart).capitalized) - \(dateFormatter.string(from: dateEnd).capitalized)"
        }
        
        cell.contentConfiguration = configuration
        
        return cell
    }
    
}

extension LessonController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = lessons[indexPath.row]
        
        navigationController?.pushViewController(ReaderController(lesson: data, idQuartely: quarterly.id, languageCode: quarterly.lang), animated: true)
        
    }
}


extension LessonController: LessonViewModelDelegate {
    func didGetLessons(_ lessons: [Lesson]?, error: DataError?) {
        self.lessons = lessons ?? []
        tabelView.reloadData()
    }
}

