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
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    var arrSurveys = [Surveys]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeImageIntoCircleShape(targetImage: image1)
        changeImageIntoCircleShape(targetImage: image2)
        changeImageIntoCircleShape(targetImage: image3)
        changeImageIntoCircleShape(targetImage: image4)
        changeImageIntoCircleShape(targetImage: image5)
        changeImageIntoCircleShape(targetImage: image6)
    }
    override func viewWillAppear(_ animated: Bool) {
        getSurvey()
    }
    
    func changeImageIntoCircleShape(targetImage: UIImageView){
        
        targetImage.layer.cornerRadius = targetImage.frame.size.width/2
        targetImage.clipsToBounds = true
    }
    
    func getSurvey(){
        guard let url = URL(string: "http://applligent.com/project/survey/api/survey") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = UserDefaults.standard.string(forKey: "token")
        let userId = UserDefaults.standard.string(forKey: "userId")
        print(token!)
        print(userId!)
//        let deviceToken = "12absp234sample"
//        let userId = "1"
        let limit = 10
        let page = 0
        
        let surveyRequest = SurveyRequest(token: token!, userId: userId!, limit: limit, page: page)
        do {
            let jsonBody = try JSONEncoder().encode(surveyRequest)
            request.httpBody = jsonBody
            print(jsonBody)
            let jsonString = String(data: jsonBody, encoding: .utf8)
            print(jsonString!)
            
        }
        catch{
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (responseData, urlResponse, error) in
            guard let data = responseData else { return }
            print(data)
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                return
            }
            
          //  print("HTTP Response is \(httpResponse)")
            
            if httpResponse.statusCode != 200 {
                print("Invalid status code \(httpResponse.statusCode)")
                return
            }
            
            do {
                let survey = try JSONDecoder().decode(SurveyRequestModel.self, from: data)
//                let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
//                print(jsonData!)
                print(survey.survey![0].question)
                
                arrSurveys = survey.survey!
             
                for arr in survey.survey!{
                    print(" Question is", arr.question)
                }
            
            }
            catch{
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                 
            }
        }
        task.resume()
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
