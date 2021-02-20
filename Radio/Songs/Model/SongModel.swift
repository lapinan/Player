//
//  SongModel.swift
//  Radio
//
//  Created by Андрей Лапин on 20.02.2021.
//

import Foundation

struct SongModel {
    func getSongs(completion: @escaping ([Song]) -> () ) {
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
                var songs: [Song] = []
                for song in json.songs {
                    let song = Song(nameString: song[1], imageString: "https://myradio24.com/\(song[2])", dataString: song[0])
                    songs.append(song)
                }
                DispatchQueue.main.async {
                    completion(songs)
                }
            }catch let error {
                print(error)
            }
        }.resume()

    }
    struct Song {
        let nameString: String
        let imageString: String
        let dataString: String
    }
}
