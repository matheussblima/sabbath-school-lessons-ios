//
//  ViewController.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 21/06/23.
//

import UIKit

class QuarterlyController: UIViewController {
    var data: [QuarterlyGroup] = []
    let languageViewModel = LanguageViewModel()
    let quarterlyViewModel = QuarterlyViewModel()
    let containerQuartelyLesson = UIView()
    let quartelyLessonController = QuartelyLessonController()
    let languageController: LanguageController
    
    let filterView = FilterView()
    
    init() {
        self.languageController = LanguageController(languageViewModel: languageViewModel)
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

extension QuarterlyController {
    private func initialSetup() {
        view.backgroundColor = .white
        
        languageViewModel.getLanguages()
        languageViewModel.add(delegates: [self, languageController])
        quarterlyViewModel.add(delegates: [self, quartelyLessonController])
        
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.collectionView.dataSource = self
        filterView.collectionView.register(FilterViewCell.self, forCellWithReuseIdentifier: FilterViewCell.indentifier)
        
        containerQuartelyLesson.translatesAutoresizingMaskIntoConstraints = false
        containerQuartelyLesson.backgroundColor = .blue
        
        quartelyLessonController.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(filterView)
        view.addSubview(containerQuartelyLesson)
        addChild(quartelyLessonController)
        containerQuartelyLesson.addSubview(quartelyLessonController.view)
        quartelyLessonController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: filterView.trailingAnchor, multiplier: 2),
            filterView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            containerQuartelyLesson.topAnchor.constraint(equalToSystemSpacingBelow: filterView.bottomAnchor, multiplier: 1),
            containerQuartelyLesson.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: containerQuartelyLesson.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: containerQuartelyLesson.bottomAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            quartelyLessonController.view.leadingAnchor.constraint(equalTo: containerQuartelyLesson.leadingAnchor),
             quartelyLessonController.view.trailingAnchor.constraint(equalTo: containerQuartelyLesson.trailingAnchor),
             quartelyLessonController.view.topAnchor.constraint(equalTo: containerQuartelyLesson.topAnchor),
             quartelyLessonController.view.bottomAnchor.constraint(equalTo: containerQuartelyLesson.bottomAnchor)
         ])
        
    }
    
    private func setupNavigation() {
        title = Constants.appName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.iconNavbarSettings(), style: .plain, target: self, action: #selector(settingButtonItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.iconNavbarLanguage(), style: .plain, target: self, action: #selector(languageButtonItemTapped))
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
    }
}

extension QuarterlyController {
    @objc private func settingButtonItemTapped() {}
    
    @objc private func languageButtonItemTapped() {
        present(UINavigationController(rootViewController: languageController), animated: true)
    }
}

extension QuarterlyController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterViewCell.indentifier, for: indexPath) as! FilterViewCell
        let data = self.data[indexPath.item]
        cell.setTitleButton(data.name)
        cell.quarterlyGroup = data
        cell.indexPath = indexPath
        cell.delegate = self
      
        if data.isSelected {
            cell.selectedButton()
        } else {
            cell.setUnSelectedButton()
        }
    
        return cell
    }
}

extension QuarterlyController: LanguageViewModelDelegate {
    func didSelectedLanguage(_ language: Language) {
        quarterlyViewModel.getQuarterlies(language: language)
    }
    
    func didGetLanguages(_ languages: [Language]?, error: DataError?) {
        quarterlyViewModel.getQuarterlies(language: languageViewModel.selectedLanguage)
    }
}

extension QuarterlyController: QuarterlyViewModelDelegate {
    func didSelectedQuarterly(_ quarterlyViewModel: QuarterlyViewModel) {}
    
    func didGetQuarterlies(_ quarterlyViewModel: QuarterlyViewModel, error: DataError?) {
        if let error = error {
            print(error)
        }
        
        self.data = quarterlyViewModel.quarterliesGroup
        filterView.collectionView.reloadData()
    }
}

extension QuarterlyController: FilterViewCellDelegate {
    func didButtonTapped(cell: FilterViewCell, indexPath: IndexPath, quarterlyGroup: QuarterlyGroup?) {
        cell.selectedButton()

        filterView.collectionView.scrollToItem(at: indexPath , at: .centeredHorizontally, animated: true)
        
        if let quarterlyGroup = quarterlyGroup {
            quarterlyViewModel.selectQuarterlyGroup(quarterlyGroup)
            self.data = quarterlyViewModel.quarterliesGroup
        }
        
        for filterViewCell in filterView.collectionView.visibleCells  {
            let filterViewCell = filterViewCell as! FilterViewCell
            if filterViewCell != cell {
                filterViewCell.setUnSelectedButton()
            }
        }
    }
}
