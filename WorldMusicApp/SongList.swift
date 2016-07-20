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
    var cellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        storeIdNumbers()
    }
    
    
func storeIdNumbers() {
    //getting the ID number of each album of the country and adding it to an array
        let apiToContact = "https://api.spotify.com/v1/search?q=music+from+mali&type=album"
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
                      //  print(self.idArray)
                     //  print(self.idArray.count)
                       // print(counter)
                       self.storePreviewUrl()
                        break
                    }
                case .Failure(let error):
            print(error)
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
                   // print(self.previewArray)
                    break
                    }
                case .Failure(let error):
                print(error)
                }
            }
        idCounter += 1
    }
}

    func storeArtistNames(){
        
    }
    func songTitles(){
        
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previewArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
            cell.textLabel?.text =  previewArray[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        cellIndex = indexPath.row
        playSongs()
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
}