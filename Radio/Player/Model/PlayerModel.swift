//
//  PlayerModel.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import Foundation
import UIKit

struct PlayerModel {
    
    func getMainSong(competion: @escaping (Player) -> () ) {
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
                let json = try JSONDecoder().decode(MainSongJSONModel.self, from: data)
                let player = Player(imageString: "https://myradio24.com/\(json.img)", nameSongString: json.song, nameArtistString: json.artist)
                DispatchQueue.main.async {
                    competion(player)
                }
            }catch let error {
                print(error)
            }
        }.resume()
    }
    func showSongsVC(viewC: PlayerViewController) -> SongsViewController {
        let vc = SongsViewController()
        vc.playerVC = viewC
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
