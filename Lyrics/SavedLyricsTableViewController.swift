//
//  SavedLyricsTableViewController.swift
//  Lyrics
//
//  Created by Rada Hristova on 31.10.20.
//

import UIKit

class SavedLyricsTableViewController: UITableViewController {

    var savedSongs: [Song]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // Since the list of saveable songs can be added to, we need to reload the table each time this screen becomes visible
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedSongs = Saver.instance.songs
    }

    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedSongs?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if let song = savedSongs?[indexPath.row] {
            cell.textLabel?.text = song.title
            cell.detailTextLabel?.text = song.artist
        }

        return cell
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We need to cast the object that started the segue to a UITableViewCell ...
        if let cell = sender as? UITableViewCell,
           /// ... so that we get its indexPath from the table ...
           let indexPath = tableView.indexPath(for: cell),
           /// ... so that we get the corresponding lyrics from the array by using the indexPath as index
           let lyrics = savedSongs?[indexPath.row].lyrics,
           // We cast the destination to LyricsViewController ...
           let destination = segue.destination as? LyricsViewController {
            /// ... so that we can set its 'lyrics' property
            destination.lyrics = lyrics
        }
    }

}
