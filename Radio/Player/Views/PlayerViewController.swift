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
        button.setImage(UIImage(named: "playButton"), for: .normal)
        button.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        return button
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
        slider.setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
        slider.setThumbImage(UIImage(named: "sldierThumb"), for: .highlighted)
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
    private let historyButtonLeft: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showSongsVC), for: .touchUpInside)
        button.setImage(UIImage(named: "history"), for: .normal)
        return button
    }()
    private let noVolumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "noVolume")
        return image
    }()
    private let yesVolumeImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "yesVolume")
        return image
    }()
    private let historyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var isShowed = false
    var isPlay = false
    
    let player = AudioPlayer()
    
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        player.volume = volumeSlider.value
        
        setBackgroundImageConstraints()
        setSongImageConstratins()
        setNameArtistLabelConstraints()
        setNameSongLabelConstraints()
        setPlayButtonConstraints()
        setNoVolumeImageConstraints()
        setYesVolumeConstraints()
        setVolumeSliderConstraints()
        setHistoryViewConstraints()
        
        
        
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
        let myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetchStates), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.backgroundImage = backgroundImage
        viewModel.songImage = songImage
        viewModel.songNameLabel = nameSongLabel
        viewModel.artistNameLabel = nameArtistLabel
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    func play() {
        if !isPlay {
            let audioItem = DefaultAudioItem(audioUrl: "https://listen2.myradio24.com/5491", sourceType: .stream)
            do {
                try player.load(item: audioItem, playWhenReady: true)
                
                try? AudioSessionController.shared.set(category: .playback)
                try? AudioSessionController.shared.activateSession()
            }catch let error {
                print(error)
            }
            player.nowPlayingInfoController.set(keyValue: NowPlayingInfoProperty.isLiveStream(true))
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
        player.volume = sender.value
    }
    @objc
    private func showSongsVC() {
        present(viewModel.showSongsVC(vc: self, backImage: backgroundImage.image!, nameSong: nameSongLabel.text!, nameArtist: nameArtistLabel.text!), animated: true)
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
        playButton.layer.cornerRadius = 30
    }
    private func setVolumeSliderConstraints() {
        view.addSubview(volumeSlider)
        volumeSlider.snp.makeConstraints { make in
            make.left.equalTo(noVolumImage.snp.right).inset(-10.29)
            make.height.equalTo(3)
            make.right.equalTo(yesVolumeImage.snp.left).inset(-10)
            make.top.equalTo(playButton.snp.bottom).inset(-34)
        }
    }
    private func setHistoryButtonConstraints() {
        historyView.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(147)
        }
        setHistory2ButtonConstratins()
    }
    private func setHistory2ButtonConstratins() {
        historyView.addSubview(historyButtonLeft)
        historyButtonLeft.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(12)
        }
    }
    private func setNoVolumeImageConstraints() {
        view.addSubview(noVolumImage)
        noVolumImage.snp.makeConstraints { make in
            make.left.equalTo(songImage.snp.left)
            make.width.equalTo(7.71)
            make.height.equalTo(12)
            make.top.equalTo(playButton.snp.bottom).inset(-30)
        }
    }
    private func setYesVolumeConstraints() {
        view.addSubview(yesVolumeImage)
        yesVolumeImage.snp.makeConstraints { make in
            make.width.equalTo(14.68)
            make.height.equalTo(12)
            make.right.equalTo(songImage.snp.right)
            make.top.equalTo(playButton.snp.bottom).inset(-30)
        }
    }
    private func setHistoryViewConstraints() {
        view.addSubview(historyView)
        historyView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(177)
            make.centerX.equalToSuperview()
            make.top.equalTo(volumeSlider.snp.bottom).inset(-34)
        }
        setHistoryButtonConstraints()
    }
}
