//
//  ViewController.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 21/06/23.
//

import UIKit

class QuarterlyController: UIViewController {
    
    var data: [String] = []
    let languageViewModel = LanguageViewModel()
    let quarterlyViewModel = QuarterlyViewModel()
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
    }
}

extension QuarterlyController {
    private func initialSetup() {
        view.backgroundColor = .white
        
        languageViewModel.getLanguages()
        languageViewModel.delegate = self
        quarterlyViewModel.delegate = self
    
        //Navigation
        title = Constants.appName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.iconNavbarSettings(), style: .plain, target: self, action: #selector(settingButtonItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.iconNavbarLanguage(), style: .plain, target: self, action: #selector(languageButtonItemTapped))
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.collectionView.dataSource = self
        filterView.collectionView.register(FilterViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    private func layout() {
        view.addSubview(filterView)
        
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: filterView.trailingAnchor, multiplier: 2),
            filterView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterViewCell
        let data = self.data[indexPath.item]
        cell.setTitleButton(data)
        
        if indexPath.item == 0 {
            cell.selectedButton()
        } else {
            cell.setUnSelectedButton()
        }
        
        
        return cell
    }
}

extension QuarterlyController: LanguageViewModelDelegate {
    func didSelectedLanguage(_ language: Language) {
        quarterlyViewModel.getQuarterlies(language: languageViewModel.selectedLanguage)
    }
    
    func didGetLanguages(_ languages: [Language]?, error: DataError?) {
        quarterlyViewModel.getQuarterlies(language: languageViewModel.selectedLanguage)
    }
}

extension QuarterlyController: QuarterlyViewModelDelegate {
    func didGetQuarterlies(quarterlies: [Quarterly]?, error: DataError?) {
        if let error = error {
            print(error)
        }
        
        guard let quarterlies = quarterlies else {
            return
        }
        
        let quarterlyGroup: Set<String> = Set(quarterlies.map({ qa in
            qa.quarterlyGroup?.name ?? "Outros"
        }))
        
        print(quarterlyGroup)
        
        self.data = Array(quarterlyGroup)
        filterView.collectionView.reloadData()
    }
}
