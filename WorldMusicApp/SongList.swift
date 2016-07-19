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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                        print(self.idArray)
                       print(self.idArray.count)
                        print(counter)
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



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previewArray.count
        
       // return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        //var arrayCounter = 0
        
      //  while(arrayCounter < previewArray.count){
            cell.textLabel?.text =  previewArray[indexPath.row]
           // arrayCounter += 1
      //  }
        return cell
    }
}