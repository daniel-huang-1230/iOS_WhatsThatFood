//
//  AddRestaurantController.swift
//  
//
//  Created by Daniel Huang on 9/2/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var photoImageView:UIImageView!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var isVisit = true
    
    @IBAction func saveButtonTapped(sender: AnyObject){
        
     
            if( nameTextField.text == "" || typeTextField.text == "" || locationTextField.text == ""){
                let warning = UIAlertController(title: "Oops", message: "One or more fields is blank. Please note that all fields are required.", preferredStyle:.alert)
                
                let cancelAction = UIAlertAction(title: "Got it", style: .cancel, handler: nil)
                warning.addAction(cancelAction)
                present(warning, animated: true, completion: nil)
            } else {
                //print the below info to the console (temporarily)
                print("Name:\(nameTextField.text!)")
                print("Type: \(typeTextField.text!)")
                print("Location: \(locationTextField.text!)")
                print("Have you been here: \(isVisit)")
                
                //return to the home screen (of the app)
                //dismiss(animated: true, completion: nil)
                
                performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        }
        
        
    }
    
    @IBAction func toggleBeenHereButton(sender: UIButton){
            //"YES" button pressed
        if sender == yesButton {
            isVisit = true
            //change the background colors of both buttons accordingly
            yesButton.backgroundColor = UIColor.red
            noButton.backgroundColor = UIColor.gray
            
        } else if sender == noButton {
            
            isVisit = false
            yesButton.backgroundColor = UIColor.gray
            noButton.backgroundColor = UIColor.red

        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {  //show the photo library only when the first cell(image cell) is selected
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary //for simplicity, the camera feature is not allowed YET
                
                imagePicker.delegate = self  //in order to implement the function in delegate protocol
                present(imagePicker, animated: true, completion: nil)
            }
            
        }

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
            
            // CODE UP the layout constraints utilizing NSLayoutContraint class
            let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            
            //turn on the constraint that we just instantiated
            
            leadingConstraint.isActive = true
            
            
            let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            
            trailingConstraint.isActive = true
            
            let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            
            topConstraint.isActive = true
            
            
            let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            
            
            bottomConstraint.isActive = true
            
            
            //close the image picker
            dismiss(animated: true, completion: nil)
        }
    }
     //We don't need the following two methods for static table view
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
