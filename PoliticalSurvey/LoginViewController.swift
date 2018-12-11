//
//  LoginViewController.swift
//  PoliticalSurvey
//
//  Created by mac on 06/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var txtContactNo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        PostLoginData()
    }
    
    func PostLoginData() {
        
        
        guard let url = URL(string: "http://applligent.com/project/survey/api/login") else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let deviceToken = "123sdf456sample"
        let loginUser = LoginRequest(emailAddress: txtEmailAddress.text!, contactNo: txtContactNo.text!, password: txtPassword.text!, deviceToken: deviceToken)
        do {
        let jsonBody = try JSONEncoder().encode(loginUser)
        request.httpBody = jsonBody
      //  print(jsonBody)
        let jsonString = String(data: jsonBody, encoding: .utf8)
        //print(jsonString!)
        }
        catch{
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (responseData, urlResponse, error) in
            
            guard let data = responseData else { return }
            //print(data)
            do {
              let sendUser = try JSONDecoder().decode(loginModel.self, from: data)
//                print(sendUser.message!)
//                print(sendUser.token!)
//                print(sendUser.userData?.userId!)
                
                let token = sendUser.token!
                let userId = sendUser.userData?.userId!
                let userDefaults = UserDefaults.standard
                userDefaults.setValue(token, forKey: "token")
                userDefaults.setValue(userId, forKey: "userId")
                userDefaults.synchronize()
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SurveyQuestionViewController") as! SurveyQuestionViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
}
