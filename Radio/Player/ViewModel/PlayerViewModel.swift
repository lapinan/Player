//
//  PlayerViewModel.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import Foundation
import UIKit
import SDWebImage

class PlayerViewModel {
    private let model = PlayerModel()
    
    weak var backgroundImage: UIImageView?
    weak var songImage: UIImageView?
    weak var artistNameLabel: UILabel?
    weak var songNameLabel: UILabel?
    
    //MARK: Intent(s)
    func getMainSong() {
        model.getMainSong { player in
            self.artistNameLabel?.text = player.nameArtistString
            self.songNameLabel?.text = player.nameSongString
            self.songImage?.sd_setImage(with: URL(string: "\(player.imageString)"), completed: nil)
            self.backgroundImage?.sd_setImage(with: URL(string: "\(player.imageString)"), completed: nil)
        }
    }
    func showSongsVC() -> SongsViewController {
        return model.showSongsVC()
    }
}
