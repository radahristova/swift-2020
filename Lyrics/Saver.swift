//
//  Saver.swift
//  Lyrics
//
//  Created by Rada Hristova on 31.10.20.
//

import Foundation

class Saver {
     
    static var instance = Saver()
    
    lazy var songs: [Song] = []
    
    func saveSongs() {
        if let data = try? JSONEncoder().encode(songs) {
            UserDefaults.standard.setValue(data, forKey: "songs")
        }
    }
    
    func getSongs() {
        if let data = UserDefaults.standard.value(forKey: "songs") as? Data,
           let songs = try? JSONDecoder().decode([Song].self, from: data) {
            self.songs = songs
        }
    }
}
