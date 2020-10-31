//
//  Song.swift
//  Lyrics
//
//  Created by Rada Hristova on 31.10.20.
//

import Foundation

struct Song: Codable {
    let artist: String
    let title: String
    var lyrics: String?
    
    init(artist: String, title: String, lyrics: String? = nil) {
        self.artist = artist
        self.title = title
        self.lyrics = lyrics
    }
}
