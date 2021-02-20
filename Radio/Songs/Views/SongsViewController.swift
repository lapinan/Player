//
//  SongsViewController.swift
//  Radio
//
//  Created by Андрей Лапин on 20.02.2021.
//

import UIKit
import SnapKit

class SongsViewController: UIViewController {
    
    //MARK: Views
    private lazy var songsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    
    
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Последние треки"
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    //MARK: Constraints

    
}
