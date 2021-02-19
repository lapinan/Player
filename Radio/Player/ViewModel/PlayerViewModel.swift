//
//  PlayerViewModel.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import Foundation

class PlayerViewModel {
    private let model = PlayerModel()
    
    //MARK: Intent(s)
    func getMainSong() {
        model.getMainSong()
    }
}
