//
//  LyricsTableViewController.swift
//  Lyrics
//
//  Created by Rada Hristova on 30.10.20.
//

import UIKit

class LyricsSearchedViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    // Its value will be passed from the previous screen after this one is initialized
    var song: Song?
    // The api object is created lazily only after the view is loaded
    lazy var api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // This object is set as its api property delegate so that it can be notified when the lyrics are downloaded
        api.delegate = self
        api.getLyrics(of: song)
    }
    
    @IBAction func tapped(_ sender: Any) {
        // When the user taps the Save button the song is added to the list of the object that can save them afterwards (of class Saver)
        let alert = UIAlertController(title: .none, message: "Would you like to save this lyrics?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { _ in
            if let song = self.song {
                Saver.instance.songs.append(song)
            }
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: .none)
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
   
}

extension LyricsSearchedViewController: APIDelegate {
    func didGetSongs(lyrics: String) {
        // When the lyrics are downloaded, the value is set to the song's lyrics property because it is nil until then
        self.song?.lyrics = lyrics
        // The network task is done on a background thread and we need to change the UI on the main one
        DispatchQueue.main.async {
            self.textView.text = lyrics
        }
    }
}
