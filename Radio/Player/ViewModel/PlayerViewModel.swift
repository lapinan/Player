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
    weak var historyView: UIView?
    
    var songs: [PlayerModel.Song] = []
    
    //MARK: Intent(s)
    func getMainSong() {
        model.getMainSong { player, songs  in
            self.artistNameLabel?.text = player.nameArtistString
            self.songNameLabel?.text = player.nameSongString
            self.historyView?.isHidden = false
            self.songs = songs
            self.songImage?.sd_setImage(with: URL(string: "\(player.imageString)"), completed: nil)
            self.backgroundImage?.sd_setImage(with: URL(string: "\(player.imageString)"), completed: nil)
        }
    }
    func showSongsVC(vc: PlayerViewController, backImage: UIImage, nameSong: String, nameArtist: String, isPlayer: Bool) -> SongsViewController {
        return model.showSongsVC(viewC: vc, backImage: backImage, nameSong: nameSong, nameArtist: nameArtist, songs: self.songs, isPlayer: isPlayer)
    }
}
