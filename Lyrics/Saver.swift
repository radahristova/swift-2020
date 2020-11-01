//
//  Saver.swift
//  Lyrics
//
//  Created by Rada Hristova on 31.10.20.
//

import Foundation

// Class that is used to save and load persistent objects
class Saver {
     
    // This instance is used throughout the app instead of creating a new one every time
    static var instance = Saver()
    
    // The array of songs that can be added to and also saved
    lazy var songs: [Song] = []
    
    func saveSongs() {
        // The array of Song are encoded into JSON ...
        if let data = try? JSONEncoder().encode(songs) {
            // ... so that it can be saved as Data to UserDefaults database
            UserDefaults.standard.setValue(data, forKey: "songs")
        }
    }
    
    func getSongs() {
        // The saved songs as Data (JSON) are loaded from the database
        if let data = UserDefaults.standard.value(forKey: "songs") as? Data,
           // A decoder is used to create an array of custom Song objects from the JSON data
           let songs = try? JSONDecoder().decode([Song].self, from: data) {
            // We set the value of the created songs to this object's property so that it can be used throughout the app (when the second tab is selected)
            self.songs = songs
        }
    }
}
