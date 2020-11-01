//
//  Song.swift
//  Lyrics
//
//  Created by Rada Hristova on 31.10.20.
//

import Foundation

/* Custom class for the song. Implements Codable so that it can be transformed to and from JSON when saving/loading from UserDefaults
 */
struct Song: Codable {
    let artist: String
    let title: String
    // This is optional because the lyrics are downloaded from the back-end API and can be set after the object is initialized
    var lyrics: String?
    
    // The lyrics parameters is optional - when it is not passed its value will be nil
    init(artist: String, title: String, lyrics: String? = nil) {
        self.artist = artist
        self.title = title
        self.lyrics = lyrics
    }
}
