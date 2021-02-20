//
//  PlayerJSONModel.swift
//  Radio
//
//  Created by Андрей Лапин on 19.02.2021.
//

import Foundation

struct MainSongJSONModel: Codable {
    let port, server: String
    let online, kbps, limit: Int
    let title, djname, song, genre: String
    let url: String
    let streamname: String
    let listeners, plisteners: Int
    let country: String?
    let artist, songtitle, img, logo: String
    let enabletable, turntable: Int
    let nextsongs: [String]
    let playlist: String
    let streams: [Stream]
    let rank: [[Rank]]
    let songs: [[String]]
}

enum Rank: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Rank.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Rank"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Stream
struct Stream: Codable {
    let mount, user: String
    let kbps: Int
    let format: String
    let url: String
}

