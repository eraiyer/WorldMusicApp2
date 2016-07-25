//
//  ViewController.swift
//  WorldMusicApp
//
//  Created by Era Iyer on 7/11/16.
//  Copyright © 2016 Era Iyer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
   

    var idArray: [String] = []
    var previewArray: [String] = []
    var countryWithPlus: String = ""
    var country: String = ""
    
    override func viewDidLoad() {
        let initialLocation = CLLocation(latitude: 36.7783, longitude: -119.4179)
        super.viewDidLoad()
     //   self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        centerMapOnLocation(initialLocation)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
    }
    
    let regionRadius: CLLocationDistance = 7000000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 1.0, regionRadius * 1.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func showAddViewController(placemark:CLPlacemark){
        self.performSegueWithIdentifier("add", sender: placemark)
    }
    
    
    
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        let location = sender.locationInView(self.mapView)
        
        let locationCoord = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoord
        
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(annotation)
        
        //convert location coordinates address
        let geoCoder = CLGeocoder()
        let loc = CLLocation(latitude: locationCoord.latitude, longitude: locationCoord.longitude)
        
        geoCoder.reverseGeocodeLocation(loc){
            (placemarks, error) -> Void in
            let placeArray = placemarks as [CLPlacemark]!

            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            if let country = placeMark.addressDictionary?["Country"] as? NSString
            {
            //this prints the list of album titles that correpsond to the location clicked on
           // self.country = country as String
             self.countryWithPlus = "\(country)".stringByReplacingOccurrencesOfString(" ", withString: "+")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       // if segue.identifier == "ButtonThreeSegue" {
            let controller = segue.destinationViewController as! songList
            controller.country = countryWithPlus
          //  controller.country = country
        
    }
}