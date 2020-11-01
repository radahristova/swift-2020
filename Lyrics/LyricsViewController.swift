//
//  LyricsViewController.swift
//  Lyrics
//
//  Created by Rada Hristova on 31.10.20.
//

import UIKit

class LyricsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    // This is set by the previous screen when segueing to this one
    var lyrics: String?
    
    // We set the text after view has loaded to make sure it is shown correctly
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = lyrics
    }

}
