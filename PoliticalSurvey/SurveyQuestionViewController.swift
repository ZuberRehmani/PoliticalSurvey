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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.image1.layer.cornerRadius = self.image1.frame.size.width/2
        self.image1.clipsToBounds = image1.layer.borderWidth == 3

    }
    
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Congratulations!", message: "Your survey has been submited Succsesfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "View Result", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

   

}
