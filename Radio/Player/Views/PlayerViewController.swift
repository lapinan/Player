//
//  PlayerViewController.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import UIKit
import SnapKit

class PlayerViewController: UIViewController {
    let viewModel = PlayerViewModel()
    
    //MARK: View
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.addBlurEffect()
        return image
    }()
    private let songImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private let nameArtistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.1
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.1
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.setTitle("Play", for: .normal)
        return button
    }()
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "Громкость: 0%"
        return label
    }()
    private let volumeSlide: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.addTarget(self, action: #selector(editSlider(_ :)), for: .valueChanged)
        slider.thumbTintColor = .white
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .white
        return slider
    }()
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        
        setBackgroundImageConstraints()
        setSongImageConstratins()
        setNameArtistLabelConstraints()
        setNameSongLabelConstraints()
        setPlayButtonConstraints()
        setVolumeLabelConstraints()
        setVolumeSliderConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.backgroundImage = backgroundImage
        viewModel.songImage = songImage
        viewModel.songNameLabel = nameSongLabel
        viewModel.artistNameLabel = nameArtistLabel
        viewModel.getMainSong()
    }
    
    
    //MARK: Actions
    @objc
    private func editSlider(_ sender: UISlider) {
        volumeLabel.text = "Громкость: \(Int(round(sender.value)))%"
    }
    
    //MARK: Constraints
    private func setBackgroundImageConstraints() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func setSongImageConstratins() {
        view.addSubview(songImage)
        songImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(songImage.snp.width)
            make.top.equalToSuperview().inset(40)
        }
        songImage.layer.cornerRadius = 10.0
    }
    private func setNameArtistLabelConstraints() {
        view.addSubview(nameArtistLabel)
        nameArtistLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(songImage.snp.bottom).inset(-20)
            make.height.equalTo(20)
        }
    }
    private func setNameSongLabelConstraints() {
        view.addSubview(nameSongLabel)
        nameSongLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(nameArtistLabel.snp.bottom)
        }
    }
    private func setPlayButtonConstraints() {
        view.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.top.equalTo(nameSongLabel.snp.bottom).inset(-20)
        }
        DispatchQueue.main.async {
            self.playButton.layer.cornerRadius = self.playButton.frame.width / 2
        }
    }
    private func setVolumeLabelConstraints() {
        view.addSubview(volumeLabel)
        volumeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(playButton.snp.bottom).inset(-40)
            make.height.equalTo(15)
        }
    }
    private func setVolumeSliderConstraints() {
        view.addSubview(volumeSlide)
        volumeSlide.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(volumeLabel.snp.bottom).inset(-20)
        }
    }
}
