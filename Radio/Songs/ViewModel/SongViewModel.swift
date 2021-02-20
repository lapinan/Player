//
//  SongViewModel.swift
//  Radio
//
//  Created by Андрей Лапин on 20.02.2021.
//

import Foundation
import UIKit

class SongViewModel {
    private let model = SongModel()
    
    var songs: [SongModel.Song] = []
    
    weak var tableView: UITableView?
    
    //MARK: Intent(s)
    func getSongs() {
        model.getSongs { songs in
            self.songs = songs
            self.tableView?.reloadData()
        }
    }
}
