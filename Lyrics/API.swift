//
//  API.swift
//  Lyrics
//
//  Created by Rada Hristova on 30.10.20.
//

import Foundation

// Protocol that needs to be implemented by the API's delegate so that the method can be called by the API and the downloaded lyrics passed as a parameter
protocol APIDelegate: class {
    func didGetSongs(lyrics: String)
}

// Custom internal networking API which is used the get lyrics from the back-end API
class API {
    
    // This reference is weak because the delegate will also have a reference to the API object and a reference cycle will be created. Also, it is optional because it can be set after the API object is initialized
    weak var delegate: APIDelegate?
    
    // https://lyricsovh.docs.apiary.io/
    func getLyrics(of song: Song?) {
        // We make sure that a song is passed as a parameter
        guard let song = song,
              // We create a URL with the API's base URL
              var url = URL(string: "https://api.lyrics.ovh/v1/") else {
            return
        }
        // We add to the url the artist's name as the a path component (.../Rihanna)
        url.appendPathComponent(song.artist)
        // We add the song's title (.../Rihanna/Umbrella)
        url.appendPathComponent(song.title)
        // We get a task for the request from the networking session manager. We make the reference to the API object weak inside the closure so that a reference cycle can't be created between the closure and the API object
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            // If we get a correct response
            guard let data = data,
                  // We translate the received JSON to a dictionary
                  let dictionary = try? JSONSerialization
            .jsonObject(with: data, options: .allowFragments) as? [String: Any],
                  // We get the value of the "lyrics" key from the dictionary
                  let lyrics = dictionary["lyrics"] as? String else {
                return
            }
            // We pass the downloaded lyrics to the delegate
            self?.delegate?.didGetSongs(lyrics: lyrics)
        }
        // We need to start the task manually
        task.resume()
    }
}
