//
//  MapViewController.swift
//  
//
//  Created by Daniel Huang on 9/2/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import MapKit //to enable the MapKit framework

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        
            super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //show more info (compass, traffic, and scale) on the map view
        mapView.showsCompass = true;
        mapView.showsTraffic = true;
        mapView.showsScale = true;
        
                       let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(restaurant.location, completionHandler: {
            placemarks, error in
            if error != nil {
                print(error!)
                return
            }
            
            if let placemarks = placemarks {
                //get the first placemark in the placemarks array
                let placemark = placemarks[0]
                
                //add annotation
                
                let annotation = MKPointAnnotation()
                
                annotation.title = self.restaurant.name
                
                annotation.subtitle = self.restaurant.type
                
                
                if let location = placemark.location {
                    
                    annotation.coordinate = location.coordinate
                    
                    //show annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated:true)

                    
                }
            }
            
            
        })

        
        mapView.delegate = self
        
        
       
        

    }
    
    //implement the func in the delegate protocol
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        
        //re-use the annotation if possible for better app performance
        
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as?  MKPinAnnotationView

        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView?.canShowCallout = true
            
        }
        annotationView?.autoresizesSubviews = true
        let leftIconView = UIImageView(frame: CGRect.init(x:0, y:0, width: 53, height: 53))
        leftIconView.image = UIImage(named: restaurant.image)
        
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        annotationView?.pinTintColor = UIColor.green //customize the color of the pin
        return annotationView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
