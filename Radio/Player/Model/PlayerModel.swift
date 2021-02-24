//
//  PlayerModel.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import Foundation
import UIKit

struct PlayerModel {
    
    func getMainSong(competion: @escaping (Player, [Song]) -> () ) {
        let urlString = "https://myradio24.com/users/5491/status.json"
        guard let url = URL(string: urlString) else {
            print("CHECK: urlString - \(urlString)")
            return
        }
        let request = URLRequest(url: url)
        let _ = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                print("CHECK: data is nil ---- ")
                return
            }
            do {
                var songs: [Song] = []
                let json = try JSONDecoder().decode(MainSongJSONModel.self, from: data)
                let player = Player(imageString: "https://myradio24.com/\(json.img)", nameSongString: json.song, nameArtistString: json.artist)
                for song in json.songs {
                    let song = Song(nameString: song[1], dataString: song[0], imageString: "https://myradio24.com/\(song[2])")
                    songs.append(song)
                }
                DispatchQueue.main.async {
                    competion(player, songs)
                }
            }catch let error {
                print(error)
            }
        }.resume()
    }
    func showSongsVC(viewC: PlayerViewController, backImage: UIImage, nameSong: String, nameArtist: String, songs: [Song], isPlayer: Bool) -> SongsViewController {
        let vc = SongsViewController()
        vc.playerVC = viewC
        vc.songs = songs
        vc.nameSongLabel.text = nameSong
        vc.nameArtistLabel.text = nameArtist
        vc.backImage.image = backImage
        vc.isPlayer = isPlayer
        return vc
    }
    
    struct Song {
        let nameString: String
        let dataString: String
        let imageString: String
    }
    
    struct Player {
        let imageString: String
        let nameSongString: String
        let nameArtistString: String
    }
}
