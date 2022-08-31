//
//  ViewController.swift
//  assignment3
//
//  Created by Yeibin Kang on 2021-11-16.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var latitude:String = ""
    var longtitude:String = ""
    let pin = MKPointAnnotation()
    
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func searchClicked(_ sender: Any) {
        
        guard let city = txtCity.text else{
            return
        }
 
        print(city)
        
        getLocation(cityName: city)
        
        
    }
    
    private func getLocation(cityName: String){
        
        self.geocoder.geocodeAddressString(cityName){
            (resultsList, error) in
            print("Waiting for response")
            
            
            if let err = error{
                print("Error while trying to geocode the city name")
                print(err)
                return
            }
            
            if(resultsList!.count == 0){
                print("No result found")
            }else{
                let placemark:CLPlacemark = resultsList!.first!
                
                print("place marker is: ")
                let lat:Double! = placemark.location?.coordinate.latitude ?? nil
   
                let lng:Double! = placemark.location?.coordinate.longitude ?? nil
               
                
                
                print(lat)
                print(lng)
                
                
                let zoomLevel = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                
                let centerOfMap = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lng ?? 0)
                
                let visibleRegion = MKCoordinateRegion(center: centerOfMap, span: zoomLevel)
                
                self.mapView.setRegion(visibleRegion, animated: true)
                
                //let pin = MKPointAnnotation()
                
                self.pin.coordinate = centerOfMap
                
                let tmpString:String = "\(lat) , \(lng)"
                self.pin.title = tmpString
                
                self.mapView.addAnnotation(self.pin)
            }
            
            
        }
    }
    
    
    @IBAction func clearClicked(_ sender: Any) {
        
        self.txtCity.text = ""
        
        self.mapView.removeAnnotation(self.pin)
        
        let region = MKCoordinateRegion(.world)
        mapView.setRegion(region, animated: true)
        
    }
    

}

