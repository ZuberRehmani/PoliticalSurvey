//
//  ViewController.swift
//  PoliticalSurvey
//
//  Created by mac on 27/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    enum SelectedPicker {
        case country
        case province
        case gender
    }
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewPicker: UIView!
    
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var takeaSurveyButtonOutlet: UIButton!
    
    var whichPickerClicked = "Gender"
    
    var arrGender = ["Male","Female"]
    var arrCountry = ["India","London"]
    var arrPervince = ["Madhya Pardesh","Uttar Pardesh","Aandhra Pardesh"]
    
    var selectedPickerType: SelectedPicker = .gender

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func selectGenderTapped(_ sender: UIButton) {
        whichPickerClicked = "Gender"
       takeaSurveyButtonOutlet.isHidden = true
       showHideGenderPicker(isShow: true)
        
    }

    
    func showHideGenderPicker(isShow: Bool) {
        
        if isShow {
             genderPicker.reloadAllComponents()
            pickerViewBottomConstraint.constant = 0
           
        }
        else {
            pickerViewBottomConstraint.constant = -(viewPicker.frame.size.height)
        }
    }

    
    @IBAction func genderCancelTapped(_ sender: UIButton) {
       
        showHideGenderPicker(isShow: false)
        takeaSurveyButtonOutlet.isHidden = false
        //genderPicker.isHidden = true
    }
    @IBAction func genderDoneTapped(_ sender: UIButton) {
        
        showHideGenderPicker(isShow: false)
        takeaSurveyButtonOutlet.isHidden = false
        //genderPicker.isHidden = true
    }
    
    
    
    
    @IBAction func countryButtonTapped(_ sender: UIButton) {
        
        whichPickerClicked = "Country"
        
        selectedPickerType = .country
        showHideGenderPicker(isShow: true)
        takeaSurveyButtonOutlet.isHidden = true
        //countryPicker.isHidden = false
    }
    
    @IBAction func pervinceButtonTapped(_ sender: UIButton) {
        
        whichPickerClicked = "Pervince"
        showHideGenderPicker(isShow: true)
        takeaSurveyButtonOutlet.isHidden = true
    }
    
    
    @IBAction func takeaSurveyTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SurveyQuestionViewController") as! SurveyQuestionViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch selectedPickerType {
        case .country:
            print("Selected picker is country picker")
        case .province:
            print("Selected picker is province picker")
        case .gender:
            print("Selected picker is gender picker")

        }
        
        if whichPickerClicked == "Gender" {
            
        txtGender.text = arrGender[row]
       
        }
        if whichPickerClicked == "Country" {

            txtCountry.text = arrCountry[row]

        }
        if whichPickerClicked == "Pervince" {
            
            txtProvince.text = arrPervince[row]
        }
        
    }
    

}
extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       if whichPickerClicked == "Gender" {
        return arrGender.count
        }
        if whichPickerClicked == "Country" {
        return arrCountry.count
        }
        if whichPickerClicked == "Pervince" {
            
            return arrPervince.count
        }
        
        return 0
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if whichPickerClicked == "Gender" {

        return arrGender[row]
        }
        if whichPickerClicked == "Country" {
    
            return arrCountry[row]
            
        }
        if whichPickerClicked == "Pervince" {
            
            return arrPervince[row]
        }
        
        return ""
    }
}
