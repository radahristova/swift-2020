//
//  LyricsTableViewController.swift
//  Lyrics
//
//  Created by Rada Hristova on 30.10.20.
//

import UIKit

class LyricsSearchedViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var song: Song?
    lazy var api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        api.getLyrics(of: song)
    }
    
    @IBAction func tapped(_ sender: Any) {
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
        self.song?.lyrics = lyrics
        DispatchQueue.main.async {
            self.textView.text = lyrics
        }
    }
}
