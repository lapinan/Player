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

    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setBackgroundImageConstraints()
        setSongImageConstratins()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.backgroundImage = backgroundImage
        viewModel.songImage = songImage
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
            make.top.equalToSuperview().inset(40)
        }
        songImage.layer.cornerRadius = 10.0
    }
    

}
