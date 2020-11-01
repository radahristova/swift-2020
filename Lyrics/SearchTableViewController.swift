//
//  SearchTableViewController.swift
//  Lyrics
//
//  Created by Rada Hristova on 30.10.20.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    private func songFromCells() -> Song {
        // We get the text inside the first cell which is for the artist's name
        let artist = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldTableViewCell)?
            .textField.text ?? ""
        // We get the title from the second cell
        let title = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? TextFieldTableViewCell)?
            .textField.text ?? ""
        // We create a Song object and return it
        return Song(artist: artist, title: title)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // The two cells are separated into 2 columns so that they can have Header titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ARTIST"
        } else {
            return "SONG"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TextFieldTableViewCell
        // We set the textfields inside the cell placeholder text to show what needs to be typed in them
        if indexPath.section == 0 {
            cell.textField.placeholder = "NAME"
        } else {
            cell.textField.placeholder = "TITLE"
        }
        return cell
    }

    // MARK: - Navigation
    // When the user taps the Search tab bar button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We cast the segue's destination to its class, to access its properties
        if let destination = segue.destination as? LyricsSearchedViewController {
            // We create a song from the typed text inside the cells and pass it to the next screen
            destination.song = songFromCells()
        }
    }

}

