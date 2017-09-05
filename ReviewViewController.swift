//
//  ReviewViewController.swift
//  
//
//  Created by Daniel Huang on 9/1/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var reviewImageView:UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var closeButton: UIButton!
    var restaurant:Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backgroundImageView.image = UIImage(named: restaurant.image)
        reviewImageView.image = UIImage(named: restaurant.image)
        
        //to achieve the blurry effect of background image
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //set up the intial state of the container view
       
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        
        let combineTransform = scaleTransform.concatenating(translateTransform)
        
        //combine two transformations
        containerView.transform = combineTransform
        
        //implement the animation of the close button (slide from right to left)
        let buttonTranslateTransform = CGAffineTransform.init(translationX: 1000, y: 0)
        closeButton.transform = buttonTranslateTransform
    }

    override func viewDidAppear(_ animated: Bool) {
        //the code that deals with the ANIMATION!!!!
//        UIView.animate(withDuration: 0.3, animations: {
//            //the final state is that the container view recovers its original size(identity transform)
//            self.containerView.transform = CGAffineTransform.identity
//        
//        })
//        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping:0.45,
                       initialSpringVelocity:0.2, options: .curveEaseInOut,
                       animations: {
                  self.containerView.transform = CGAffineTransform.identity
                  
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                self.closeButton.transform = CGAffineTransform.identity
        }
        
        )
        
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
        
        
        
    }
    

}
