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
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // if let cell = sender as? JokeTableViewCell,
       let indexPath = tableView.indexPath(for: cell),
       let category = categories?[indexPath.row],
       let destination = segue.destination as? JokeViewController {
        destination.networkManager = networkManager
        destination.category = category
 */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let lyrics = savedSongs?[indexPath.row].lyrics,
           let destination = segue.destination as? LyricsViewController {
            destination.lyrics = lyrics
        }
    }

}
