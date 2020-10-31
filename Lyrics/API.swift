//
//  API.swift
//  Lyrics
//
//  Created by Rada Hristova on 30.10.20.
//

import Foundation

protocol APIDelegate: class {
    func didGetSongs(lyrics: String)
}

class API {
    
    weak var delegate: APIDelegate?
    
    // https://lyricsovh.docs.apiary.io/
    func getLyrics(of song: Song?) {
        guard let song = song,
              var url = URL(string: "https://api.lyrics.ovh/v1/") else {
            return
        }
        url.appendPathComponent(song.artist)
        url.appendPathComponent(song.title)
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  let dictionary = try? JSONSerialization
            .jsonObject(with: data, options: .allowFragments) as? [String: Any],
                  let lyrics = dictionary["lyrics"] as? String else {
                return
            }
            self?.delegate?.didGetSongs(lyrics: lyrics)
        }
        task.resume()
    }
}
