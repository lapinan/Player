//
//  PlayerViewController.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import UIKit
import SnapKit
import ProgressHUD
import SwiftAudio

class PlayerViewController: UIViewController {
    let viewModel = PlayerViewModel()
    
    //MARK: View
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0.5
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
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        return button
    }()
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.minimumScaleFactor = 0.1
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Громкость: 0%"
        return label
    }()
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.addTarget(self, action: #selector(editSlider(_ :)), for: .valueChanged)
        slider.thumbTintColor = .white
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .white
        slider.value = 50.0
        return slider
    }()
    private let historyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Предыдущие треки", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(showSongsVC), for: .touchUpInside)
        return button
    }()
    
    var isShowed = false
    var isPlay = false
    
    let player = AudioPlayer()
    
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        volumeLabel.text = "Громкость: \(Int(round(volumeSlider.value)))%"
        player.volume = volumeSlider.value
        
        setBackgroundImageConstraints()
        setSongImageConstratins()
        setNameArtistLabelConstraints()
        setNameSongLabelConstraints()
        setPlayButtonConstraints()
        setVolumeLabelConstraints()
        setVolumeSliderConstraints()
        setHistoryButtonConstraints()
        
        if !isShowed {
            ProgressHUD.animationType = .circleStrokeSpin
            ProgressHUD.show()
            viewModel.getMainSong()
            isShowed = !isShowed
            ProgressHUD.dismiss()
        }
        
        
        statusWithTimer()
    }
    
    func statusWithTimer() {
        let myTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(fetchStates), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProgressHUD.dismiss()
        viewModel.backgroundImage = backgroundImage
        viewModel.songImage = songImage
        viewModel.songNameLabel = nameSongLabel
        viewModel.artistNameLabel = nameArtistLabel
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    private func play() {
        if !isPlay {
            let audioItem = DefaultAudioItem(audioUrl: "https://listen2.myradio24.com/5491", sourceType: .stream)
            do {
                try player.load(item: audioItem, playWhenReady: true)
            }catch let error {
                print(error)
            }
            player.play()
            playButton.setTitle("Stop", for: .normal)
            isPlay = !isPlay
        } else {
            player.stop()
            isPlay = !isPlay
            playButton.setTitle("Play", for: .normal)
        }
    }
    
    //MARK: Actions
    @objc
    private func editSlider(_ sender: UISlider) {
        volumeLabel.text = "Громкость: \(Int(round(sender.value)))%"
        player.volume = sender.value
    }
    @objc
    private func showSongsVC() {
        present(viewModel.showSongsVC(vc: self), animated: true)
    }
    @objc private func playMusic() {
        play()
    }
    @objc private func fetchStates() {
        viewModel.getMainSong()
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        songImage.layer.cornerRadius = 10.0
    }
    private func setNameArtistLabelConstraints() {
        view.addSubview(nameArtistLabel)
        nameArtistLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(songImage.snp.left)
            make.top.equalTo(songImage.snp.bottom).inset(-20)
            make.height.equalTo(20)
        }
    }
    private func setNameSongLabelConstraints() {
        view.addSubview(nameSongLabel)
        nameSongLabel.snp.makeConstraints { make in
            make.left.equalTo(songImage.snp.left)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(nameArtistLabel.snp.bottom).inset(-10)
        }
    }
    private func setPlayButtonConstraints() {
        view.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.top.equalTo(nameSongLabel.snp.bottom).inset(-20)
        }
        DispatchQueue.main.async {
            self.playButton.layer.cornerRadius = self.playButton.frame.width / 2
        }
    }
    private func setVolumeLabelConstraints() {
        view.addSubview(volumeLabel)
        volumeLabel.snp.makeConstraints { make in
            make.left.equalTo(songImage.snp.left)
            make.right.equalTo(playButton.snp.left)
            make.height.equalTo(20)
            make.top.equalTo(playButton.snp.bottom).inset(-20)
        }
    }
    private func setVolumeSliderConstraints() {
        view.addSubview(volumeSlider)
        volumeSlider.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(volumeLabel.snp.left)
            make.height.equalTo(0.1)
            make.top.equalTo(volumeLabel.snp.bottom).inset(-6)
        }
    }
    private func setHistoryButtonConstraints() {
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(volumeSlider.snp.bottom).inset(-20)
            make.height.equalTo(30)
        }
    }
}
