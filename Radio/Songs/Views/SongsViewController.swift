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
        table.backgroundColor = .clear
        table.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.id)
        table.rowHeight = 90
        return table
    }()
    let backImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.5
        image.addBlurEffect()
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let myNavBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Предыдущие треки"
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        return label
    }()
    private let myTabBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        return button
    }()
    let nameArtistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    let nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
        label.font = .systemFont(ofSize: 16)
        return label
    }()
   

    weak var playerVC: PlayerViewController?
    var songs: [PlayerModel.Song] = []
    var isPlayer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black 
    
        setBackImageConstraints()
        setMyNavBarConstraints()
        setMyTabBarViewConstraints()
        setSongsTableViewConstraints()
        
        if isPlayer {
            playButton.setImage(UIImage(named: "stopButton"), for: .normal)
            isPlayer = !isPlayer
        } else {
            playButton.setImage(UIImage(named: "playButton"), for: .normal)
            isPlayer = !isPlayer
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        viewModel.tableView = songsTableView
//        viewModel.getSongs()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //MARK: Constraints
    private func setSongsTableViewConstraints() {
        view.addSubview(songsTableView)
        songsTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(myNavBar.snp.bottom)
            make.bottom.equalTo(myTabBarView.snp.top)
        }
    }
    
    
    //MARK: Actions
    @objc
    private func playMusic() {
        playerVC?.play()
        if isPlayer {
            playButton.setImage(UIImage(named: "stopButton"), for: .normal)
            isPlayer = !isPlayer
        } else {
            playButton.setImage(UIImage(named: "playButton"), for: .normal)
            isPlayer = !isPlayer
        }

    }
    
    private func setBackImageConstraints() {
        view.addSubview(backImage)
        backImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func setMyNavBarConstraints() {
        view.addSubview(myNavBar)
        myNavBar.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(43)
        }
        myNavBar.addSubview(myTitleLabel)
        myTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
    }
    private func setMyTabBarViewConstraints() {
        view.addSubview(myTabBarView)
        myTabBarView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(94)
        }
        setPlayButtonConstraints()
        setNameArtistLabelConstraints()
        setNameSongLabelConstraints()
    }
    private func setPlayButtonConstraints() {
        myTabBarView.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(11)
            make.height.width.equalTo(40)
            make.left.equalToSuperview().inset(25)
        }
    }
    private func setNameArtistLabelConstraints() {
        myTabBarView.addSubview(nameArtistLabel)
        nameArtistLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalToSuperview().inset(6)
            make.left.equalTo(playButton.snp.right).inset(-10)
            make.right.equalTo(50)
        }
    }
    private func setNameSongLabelConstraints() {
        myTabBarView.addSubview(nameSongLabel)
        nameSongLabel.snp.makeConstraints { make in
            make.height.equalTo(19)
            make.left.equalTo(playButton.snp.right).inset(-10)
            make.top.equalTo(nameArtistLabel.snp.bottom)
            make.right.equalToSuperview().inset(20)
        }
    }
}

//MARK: DataSource
extension SongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.id) as? SongTableViewCell {
            cell.selectionStyle = .none
            
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.backgroundView?.backgroundColor = .clear
            
            let song = songs[indexPath.row]
            
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
