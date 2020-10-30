//
//  API.swift
//  Lyrics
//
//  Created by Rada Hristova on 30.10.20.
//

import Foundation

typealias Song = (artist: String, title: String)

class API {
    static func lyrics(of song: Song, completionHandler: @escaping (String)->()) {
        guard var url = URL(string: "https://api.lyrics.ovh/v1/") else {
            return
        }
        url.appendPathComponent(song.artist)
        url.appendPathComponent(song.title)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let dictionary = try? JSONSerialization
            .jsonObject(with: data, options: .allowFragments) as? [String: Any],
                  let lyrics = dictionary["lyrics"] as? String else {
                return
            }
            completionHandler(lyrics)
        }
        task.resume()
    }
}
