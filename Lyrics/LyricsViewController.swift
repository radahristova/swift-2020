//
//  LyricsViewController.swift
//  Lyrics
//
//  Created by Rada Hristova on 31.10.20.
//

import UIKit

class LyricsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var lyrics: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = lyrics
    }

}
