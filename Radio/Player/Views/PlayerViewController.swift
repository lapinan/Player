//
//  PlayerViewController.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import UIKit
import SnapKit
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
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "playButton"), for: .normal)
        button.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        return button
    }()
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.0
        slider.maximumValue = 50.0
        slider.addTarget(self, action: #selector(editSlider(_ :)), for: .valueChanged)
        slider.thumbTintColor = .white
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
        slider.setThumbImage(UIImage(named: "sldierThumb"), for: .highlighted)
        slider.value = 25.0
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
    private let upViewConst: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    private let bottomSongImageViewConst: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    private let lowerViewConst: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    private let topHistoryViewConst: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    private let volumeView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let topVolumeViewConst: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    private let playView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var isShowed = false
    var isPlay = false
    
    let player = AudioPlayer()
    
    let songsViewController = SongsViewController()
    

    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        player.volume = volumeSlider.value
        
        
        
        setBackgroundImageConstraints()
        
        setUpViewConstConst()
        setSongImageConstraints()
        
        setBottomSongImageViewConst()
        setArtistNameLabelConstraints()
    
        
        setLowerViewConstConst()
        setHistoryViewConstratins()
        topHistoryViewConstConstraints()
        
        
        setVolumeViewConstraints()
        
        setTopVolumeViewConstConstratins()
    
        setSongNameLabelConstraints()
        
        setPlayButtonConstraints()
        
        
        if !isShowed {
            viewModel.getMainSong()
            isShowed = !isShowed
        }
        
        
        statusWithTimer()
    }
    
    func statusWithTimer() {
        let myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetchStates), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        historyView.isHidden = true 
        
        viewModel.backgroundImage = backgroundImage
        viewModel.songImage = songImage
        viewModel.songNameLabel = nameSongLabel
        viewModel.artistNameLabel = nameArtistLabel
        viewModel.historyView = historyView
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
            playButton.setImage(UIImage(named: "stopButton"), for: .normal)
            isPlay = !isPlay
        } else {
            player.stop()
            isPlay = !isPlay
            playButton.setImage(UIImage(named: "playButton"), for: .normal)
        }
    }
    
    //MARK: Actions
    @objc
    private func editSlider(_ sender: UISlider) {
        player.volume = sender.value
    }
    @objc
    private func showSongsVC() {
        present(viewModel.showSongsVC(vc: self, backImage: backgroundImage.image!, nameSong: nameSongLabel.text!, nameArtist: nameArtistLabel.text!, isPlayer: isPlay), animated: true)
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
    private func setSongImageConstraints() {
        view.addSubview(songImage)
        songImage.snp.makeConstraints { make in
            make.top.equalTo(upViewConst.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(UIScreen.main.bounds.width * 0.70)
        }
        DispatchQueue.main.async {
            self.songImage.layer.cornerRadius = 10.0
        }
    }
    private func setPlayButtonConstraints() {
        view.addSubview(playView)
        playView.snp.makeConstraints { make in
            make.left.centerX.equalToSuperview()
            make.bottom.equalTo(volumeView.snp.top)
            make.top.equalTo(nameSongLabel.snp.bottom)
        }
        
        playView.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(60)
        }
    }
    
    
    private func setUpViewConstConst() {
        view.addSubview(upViewConst)
        upViewConst.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    private func setBottomSongImageViewConst() {
        view.addSubview(bottomSongImageViewConst)
        bottomSongImageViewConst.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.03)
            make.top.equalTo(songImage.snp.bottom)
        }
    }
    private func setArtistNameLabelConstraints() {
        view.addSubview(nameArtistLabel)
        nameArtistLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.top.equalTo(bottomSongImageViewConst.snp.bottom)
        }
    }
    
    
    private func setSongNameLabelConstraints() {
        view.addSubview(nameSongLabel)
        nameSongLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameArtistLabel.snp.bottom)
            make.height.equalTo(38)
        }
    }
    
    
    
    private func setLowerViewConstConst() {
        view.addSubview(lowerViewConst)
        lowerViewConst.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.05)
        }
    }
    private func setHistoryViewConstratins() {
        view.addSubview(historyView)
        historyView.snp.makeConstraints { make in
            make.width.equalTo(177)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(lowerViewConst.snp.top)
        }
        historyView.addSubview(historyButtonLeft)
        historyButtonLeft.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(12)
            make.width.equalTo(20)
        }
        historyView.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.width.equalTo(147)
            make.height.equalTo(30)
            make.right.equalToSuperview()
        }
    }
    private func topHistoryViewConstConstraints() {
        view.addSubview(topHistoryViewConst)
        topHistoryViewConst.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.03)
            make.bottom.equalTo(historyView.snp.top)
        }
    }
    private func setVolumeViewConstraints() {
        view.addSubview(volumeView)
        volumeView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(topHistoryViewConst.snp.top)
            make.height.equalTo(12)
        }
        
        volumeView.addSubview(noVolumImage)
        noVolumImage.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(8.84)
            make.height.equalTo(12)
            make.centerY.equalToSuperview()
        }
        volumeView.addSubview(yesVolumeImage)
        yesVolumeImage.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(12)
            make.height.equalTo(16.81)
        }
        volumeView.addSubview(volumeSlider)
        volumeSlider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(noVolumImage.snp.right).inset(-9)
            make.right.equalTo(yesVolumeImage.snp.left).inset(-9)
        }
    }
    
    private func setTopVolumeViewConstConstratins() {
//        view.addSubview(topVolumeViewConst)
//        topVolumeViewConst.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.05)
//            make.bottom.equalTo(volumeView.snp.top)
//        }
    }
    
}
