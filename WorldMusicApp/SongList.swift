//
//  SongList.swift
//  WorldMusicApp
//
//  Created by Era Iyer on 7/18/16.
//  Copyright © 2016 Era Iyer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AVFoundation

class songList: UITableViewController{
    var idArray: [String] = []
    var previewArray: [String] = []
    var songsArray: [String] = []
    var cellIndex = 0
    var country: String = ""
    var countryNoPlus: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.72, green:0.91, blue:0.86, alpha:1.0);
        self.navigationController?.navigationBarHidden = false
        storeIdNumbers()
    }
    
    
func storeIdNumbers() {
    //getting the ID number of each album of the country and adding it to an array

    if country == "Myanmar+(Burma)" {
        let apiToContact = "https://api.spotify.com/v1/search?q=music+from+burma&type=album"
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var counter = 0
                    // print(json["albums"])
                    for(_,_) in json["albums"]{
                        if let albumID = json["albums"]["items"][counter]["id"].string {
                            var albumLinkWithID = "https://api.spotify.com/v1/albums/\(albumID)/tracks"
                            self.idArray.append(albumLinkWithID)
                            counter+=1
                        }
                    }
                    self.tableView.reloadData()
                    self.storePreviewUrl()
                    self.storeSongs()
                    break
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    else if country == "United+Kingdom" {
        let apiToContact = "https://api.spotify.com/v1/search?q=british&type=album"
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var counter = 0
                    // print(json["albums"])
                    for(_,_) in json["albums"]{
                        if let albumID = json["albums"]["items"][counter]["id"].string {
                            var albumLinkWithID = "https://api.spotify.com/v1/albums/\(albumID)/tracks"
                            self.idArray.append(albumLinkWithID)
                            counter+=1
                        }
                    }
                    self.tableView.reloadData()
                    self.storePreviewUrl()
                    self.storeSongs()
                    break
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }
   else if country == "United+States" {
        let apiToContact = "https://api.spotify.com/v1/search?q=pop+music&type=album"
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var counter = 0
                    // print(json["albums"])
                    for(_,_) in json["albums"]{
                        if let albumID = json["albums"]["items"][counter]["id"].string {
                            var albumLinkWithID = "https://api.spotify.com/v1/albums/\(albumID)/tracks"
                            self.idArray.append(albumLinkWithID)
                            counter+=1
                        }
                    }
                    self.tableView.reloadData()
                    self.storePreviewUrl()
                    self.storeSongs()
                    break
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    else if country == "Iceland" {
        let apiToContact = "https://api.spotify.com/v1/search?q=iceland&type=album"
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var counter = 0
                    // print(json["albums"])
                    for(_,_) in json["albums"]{
                        if let albumID = json["albums"]["items"][counter]["id"].string {
                            var albumLinkWithID = "https://api.spotify.com/v1/albums/\(albumID)/tracks"
                            self.idArray.append(albumLinkWithID)
                            counter+=1
                        }
                    }
                    self.tableView.reloadData()
                    self.storePreviewUrl()
                    self.storeSongs()
                    break
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    else if country == "North+Korea" || country == "South+Korea" {
        let apiToContact = "https://api.spotify.com/v1/search?q=music+from+korea&type=album"
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var counter = 0
                    // print(json["albums"])
                    for(_,_) in json["albums"]{
                        if let albumID = json["albums"]["items"][counter]["id"].string {
                            var albumLinkWithID = "https://api.spotify.com/v1/albums/\(albumID)/tracks"
                            self.idArray.append(albumLinkWithID)
                            counter+=1
                        }
                    }
                    
                    self.tableView.reloadData()
                    self.storePreviewUrl()
                    self.storeSongs()
                    break
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    else if country == "Bahamas" {
        let apiToContact = "https://api.spotify.com/v1/search?q=bahamas&type=album"
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var counter = 0
                    // print(json["albums"])
                    for(_,_) in json["albums"]{
                        if let albumID = json["albums"]["items"][counter]["id"].string {
                            var albumLinkWithID = "https://api.spotify.com/v1/albums/\(albumID)/tracks"
                            self.idArray.append(albumLinkWithID)
                            counter+=1
                        }
                    }
                    
                    self.tableView.reloadData()
                    self.storePreviewUrl()
                    self.storeSongs()
                    break
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
        
    else {
        let apiToContact = "https://api.spotify.com/v1/search?q=music+from+\(country)&type=album"
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
                switch response.result {
                    case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                    var counter = 0
                       // print(json["albums"])
                        for(_,_) in json["albums"]{
                            if let albumID = json["albums"]["items"][counter]["id"].string {
                                var albumLinkWithID = "https://api.spotify.com/v1/albums/\(albumID)/tracks"
                                self.idArray.append(albumLinkWithID)
                                counter+=1
                            }
                        }
                        
                       self.tableView.reloadData()
                       self.storePreviewUrl()
                       self.storeSongs()
                       break
                    }
                case .Failure(let error):
            print(error)
            }
        }
    }
}
    
    func storePreviewUrl(){
    var idCounter =  0
    while idCounter < self.idArray.count {
        let apiToContact = self.idArray[idCounter]
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
                case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    var counter = 0
                    for(_, _) in json["items"]{
                        if let previewUrl = json["items"][counter]["preview_url"].string {
                            self.previewArray.append(previewUrl)
                            counter += 1
                            }
                        }
                    self.tableView.reloadData()
                    print(self.previewArray)
                    break
                    }
                case .Failure(let error):
                print(error)
                }
            }
        idCounter += 1
    }
}
   func storeSongs(){
        var idCounter =  0
        while idCounter < self.idArray.count {
            let apiToContact = self.idArray[idCounter]
            Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
                switch response.result {
                    case .Success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            var counter = 0
                            for(_, _) in json["items"]{
                                if let songs = json["items"][counter]["name"].string {
                                    self.songsArray.append(songs)
                                    counter += 1
                                }
                            }
                            self.tableView.reloadData()
                             print(self.songsArray)
                            break
                    }
                case .Failure(let error):
                    print(error)
                }
            }
            idCounter += 1
    }
 }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return songsArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        cell.textLabel?.text = songsArray[indexPath.row]
        
        cell.textLabel!.textColor =  UIColor(red:0.72, green:0.91, blue:0.86, alpha:1.0)
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(17.0)
        cell.textLabel?.font = UIFont (name: "Gill Sans", size: 17)
        
        cell.prevUrl = previewArray[indexPath.row]
        if cell.prevUrl == previewArray[cellIndex] {
            cell.textLabel!.textColor = UIColor(red:0.69, green:0.90, blue:0.49, alpha:1.0)
        }
        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        cellIndex = indexPath.row
        playSongs()
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        countryNoPlus = "\(country)".stringByReplacingOccurrencesOfString("+", withString: " ")
        let label = UILabel(frame: CGRectMake(0, 0, tableView.frame.size.width, 30.0))
        label.text = countryNoPlus
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(19.0)
        label.font = UIFont (name: "Gill Sans", size: 25)
        label.textColor =  UIColor(red:0.72, green:0.91, blue:0.86, alpha:1.0)
        label.backgroundColor = UIColor.blackColor()
        return label
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    var player = AVPlayer()
    
    func playSongs() {
        self.tableView.reloadData()
        let url = previewArray[cellIndex]
        let playerItem = AVPlayerItem( URL:NSURL( string:url )! )
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
        player.play()
    }
    
    
    @IBAction func playAllSongs(sender: AnyObject) {
        cellIndex+=1
        if cellIndex < previewArray.count{
            playSongs()
        }
    }
}