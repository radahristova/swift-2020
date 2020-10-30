//
//  SearchTableViewController.swift
//  Lyrics
//
//  Created by Rada Hristova on 30.10.20.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    private func songFromCells() -> Song {
        let artist = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldTableViewCell)?
            .textField.text ?? ""
        let title = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? TextFieldTableViewCell)?
            .textField.text ?? ""
        return Song(artist, title)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ARTIST"
        } else {
            return "SONG"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TextFieldTableViewCell
        if indexPath.section == 0 {
            cell.textField.placeholder = "NAME"
        } else {
            cell.textField.placeholder = "TITLE"
        }
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LyricsTableViewController {
            destination.song = songFromCells()
        }
    }

}
