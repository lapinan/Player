//
//  SongTableViewCell.swift
//  Radio
//
//  Created by Андрей Лапин on 20.02.2021.
//

import UIKit
import SnapKit

class SongTableViewCell: UITableViewCell {
    static let id = "SongTableViewCell"
    
    
    //MARK: Views
    let songImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .black
        label.alpha = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    let songTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .black
        label.alpha = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSongImageConstraints()
        setArtistNameLabelConstraints()
        setSongNameLabelConstraints()
        setTimeSongLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        songImage.layer.cornerRadius = 10.0
    }
    
    //MARK: Constraints
    private func setSongImageConstraints() {
        addSubview(songImage)
        songImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(songImage.snp.height)
            make.centerY.equalToSuperview()
        }
    }
    private func setArtistNameLabelConstraints() {
        addSubview(artistNameLabel)
        artistNameLabel.snp.makeConstraints { make in
            make.left.equalTo(songImage.snp.right).inset(-10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(16)
            make.top.equalTo(songImage.snp.top)
        }
    }
    private func setSongNameLabelConstraints() {
        addSubview(songNameLabel)
        songNameLabel.snp.makeConstraints { make in
            make.left.equalTo(artistNameLabel.snp.left)
            make.top.equalTo(artistNameLabel.snp.bottom)
            make.right.equalTo(artistNameLabel.snp.right)
            make.height.equalTo(16)
        }
    }
    private func setTimeSongLabel() {
        addSubview(songTimeLabel)
        songTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(artistNameLabel.snp.left)
            make.right.equalTo(artistNameLabel.snp.right)
            make.height.equalTo(13)
            make.bottom.equalTo(songImage.snp.bottom)
        }
    }
}
