//
//  SongsViewController.swift
//  Radio
//
//  Created by Андрей Лапин on 20.02.2021.
//

import UIKit
import SnapKit
import SDWebImage
import ProgressHUD

class SongsViewController: UIViewController {
    let viewModel = SongViewModel()
    
    //MARK: Views
    private lazy var songsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .darkGray
        table.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.id)
        table.rowHeight = 70
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    
        setSongsTableViewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        viewModel.tableView = songsTableView
        viewModel.getSongs()
        ProgressHUD.dismiss()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //MARK: Constraints
    private func setSongsTableViewConstraints() {
        view.addSubview(songsTableView)
        songsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: DataSource
extension SongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.id) as? SongTableViewCell {
            cell.selectionStyle = .none
            let song = viewModel.songs[indexPath.row]
            
            let names = song.nameString.components(separatedBy: "-")
            
            if names.count > 1 {
                cell.artistNameLabel.text = names[0]
                cell.songNameLabel.text = names[1]
            } else { cell.artistNameLabel.text = names[0] }
            cell.songTimeLabel.text = song.dataString
            cell.songImage.sd_setImage(with: URL(string: song.imageString), completed: nil)
            
            return cell
        }
        return UITableViewCell()
    }
}

extension SongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
