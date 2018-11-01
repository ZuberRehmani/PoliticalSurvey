//
//  SurveyQuestionViewController.swift
//  PoliticalSurvey
//
//  Created by mac on 29/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SurveyQuestionViewController: UIViewController {

   
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeImageIntoCircleShape(targetImage: image1)
        changeImageIntoCircleShape(targetImage: image2)
        changeImageIntoCircleShape(targetImage: image3)
        changeImageIntoCircleShape(targetImage: image4)
        changeImageIntoCircleShape(targetImage: image5)
        changeImageIntoCircleShape(targetImage: image6)

    }
    
    func changeImageIntoCircleShape(targetImage: UIImageView){
        
        targetImage.layer.cornerRadius = targetImage.frame.size.width/2
        targetImage.clipsToBounds = true
    }
    
    
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Congratulations!", message: "Your survey has been submited Succsesfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "View Result", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SurveyListViewController") as! SurveyListViewController
            self.navigationController?.pushViewController(vc, animated: true)

        }))
       self.present(alert, animated: true, completion: nil)
        
    }
    

   

}
