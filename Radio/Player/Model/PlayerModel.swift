//
//  PlayerModel.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import Foundation

struct PlayerModel {
    
    func getMainSong() {
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
                print(json)
            }catch let error {
                print(error)
            }
        }.resume()
    }
    
    struct Player {
        let imageString: String
        let nameSongString: String
        let nameArtistString: String
    }
}
