//
//  RestaurantDetailViewController.swift
//  
//
//  Created by Daniel Huang on 21/7/2017.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MapKit // to enable the Mapkit framework
class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var tableView:UITableView!
    
    var restaurant:Restaurant!

    
    @IBAction func close(segue: UIStoryboardSegue){
        
        //unwind function
    }
    
    @IBAction func ratingButtonTapped(segue: UIStoryboardSegue){
        if let rating = segue.identifier {
            restaurant.isVisited = true
            
            switch rating {
            case "great": restaurant.rating = "Absolutely love it ! Must try"
            case "good" : restaurant.rating = "The food is pretty good"
            case "dislike": restaurant.rating = "I am not really diggin it"
            default: break
                
            }
            
        }
        tableView.reloadData() //update the table
    }
    
    
    @IBOutlet var mapView:MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantImageView.image = UIImage(named: restaurant.image)
        
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        title = restaurant.name
        
        navigationController?.hidesBarsOnSwipe = false
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        //to detect the tapping event on the map view UI in detail veiw
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        
        // the following codes retrieve the current location of the selected restaurant
        
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
                
                if let location = placemark.location {
                    //show annotation
                    
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    //set the zoom-in radius
                    
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    
                    self.mapView.setRegion(region, animated: false)
                    
                }
            }
        
        
        })
        
    }
    
    @objc func showMap(){
        
        performSegue(withIdentifier: "showMap", sender: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableViewCell
        
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phone
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before. \(restaurant.rating)": "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    } 
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showReview" {
            
            //send the restaurant object to ReviewViewController
                let destinationController = segue.destination as! ReviewViewController
                destinationController.restaurant = restaurant
            
        }else if segue.identifier == "showMap" {
            
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
            
        }
        
        
        
        
    }
    

}
