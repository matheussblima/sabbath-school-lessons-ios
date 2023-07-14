//
//  ReaderController.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation
import UIKit

class ReaderController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        layout()
    }
}

extension ReaderController {
    private func initialSetup() {}
    
    private func layout() {}
    
    private func setupNavigation() {
        title = "Reader"
        navigationItem.largeTitleDisplayMode = .never
    }
}
