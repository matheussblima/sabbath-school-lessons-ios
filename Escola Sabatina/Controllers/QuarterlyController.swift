//
//  ViewController.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 21/06/23.
//

import UIKit

class QuarterlyController: UIViewController {
    
    var data: [String] = ["Lição Jovem", "Lição Adutos", "Livros", "Teste1", "Teste2", "Teste 3"]
    
    let filterView = FilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        layout()
    }
}

// MARK: Setup
extension QuarterlyController {
    private func initialSetup() {
        view.backgroundColor = .white
        
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

// MARK: Actions
extension QuarterlyController {
    @objc private func settingButtonItemTapped() {}
    
    @objc private func languageButtonItemTapped() {
        let languageController = LanguageController()
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
        return cell
    }
}
