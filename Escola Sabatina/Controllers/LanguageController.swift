//
//  LanguageController.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 23/06/23.
//

import Foundation
import UIKit

class LanguageController: UIViewController {
    let languageViewModel = LanguageViewModel()
    var languages: [Language]?
    var selectedLanguage: Language?
    
    let tabelView = UITableView()
    
    override func viewDidLoad() {
        initialSetup()
        layout()
    }
}

extension LanguageController {
    private func initialSetup() {
        view.backgroundColor = .white
        title = "Languages"

        languageViewModel.delegate = self
        languageViewModel.getLanguages()
        
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(UITableViewCell.self, forCellReuseIdentifier: "cellLang")
    }
    
    private func layout() {
        view.addSubview(tabelView)

        NSLayoutConstraint.activate([
            tabelView.topAnchor.constraint(equalTo: view.topAnchor),
            tabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LanguageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let languages = languages else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLang", for: indexPath)
        let language = languages[indexPath.row]
        cell.accessoryType = .none
        
        if language == languageViewModel.selectedLanguage {
            cell.accessoryType = .checkmark
        }
        
        cell.textLabel?.text = language.name.localized
        
        return cell
    }
}

extension LanguageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tabelView.deselectRow(at: indexPath, animated: true)
        
        if let languages = languages {
            languageViewModel.selectedLanguage = languages[indexPath.row]
            tableView.reloadData()
        }
        
    }
}

extension LanguageController: LanguageViewModelDelegate {
    func didGetLanguages(_ languages: [Language]?, error: DataError?) {
        self.languages = languages
        tabelView.reloadData()
    }
}
