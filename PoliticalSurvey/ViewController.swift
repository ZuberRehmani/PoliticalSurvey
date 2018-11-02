//
//  ViewController.swift
//  PoliticalSurvey
//
//  Created by mac on 27/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

//protocol SignupFormDelegate {
//    func singupField(name: String, mobile: String, email: String, gender: String, country: String, province: String )
//}

class ViewController: UIViewController {
   
    enum SelectedPicker {
        case country
        case province
        case gender
    }
    
    //var singupFormFieldDelegate: SignupFormDelegate?
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewPicker: UIView!
    @IBOutlet weak var commonPicker: UIPickerView!
    @IBOutlet weak var takeaSurveyButtonOutlet: UIButton!
    
    
    var arrGender = ["Male","Female"]
    var arrCountry = ["India","London"]
    var arrProvince = ["Madhya Pardesh","Uttar Pardesh","Aandhra Pardesh"]
    
    var selectedPickerType: SelectedPicker = .gender

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func selectGenderTapped(_ sender: UIButton) {
       
        selectedPickerType = .gender
       takeaSurveyButtonOutlet.isHidden = true
       showAndHideCommonPicker(isShow: true)
        
    }

    
    func showAndHideCommonPicker(isShow: Bool) {
        
        if isShow {
             commonPicker.reloadAllComponents()
            pickerViewBottomConstraint.constant = 0
        }
        else {
            pickerViewBottomConstraint.constant = -(viewPicker.frame.size.height)
        }
    }

    
    @IBAction func commonPickerCancelTapped(_ sender: UIButton) {
        
        showAndHideCommonPicker(isShow: false)
        takeaSurveyButtonOutlet.isHidden = false
        
    }
    
    
    @IBAction func commonPickerDoneTapped(_ sender: UIButton) {
        
        showAndHideCommonPicker(isShow: false)
        takeaSurveyButtonOutlet.isHidden = false
    
    }
    
    
    
    
    @IBAction func countryButtonTapped(_ sender: UIButton) {
        
        selectedPickerType = .country
        showAndHideCommonPicker(isShow: true)
        takeaSurveyButtonOutlet.isHidden = true
        
    }
    
    @IBAction func provinceButtonTapped(_ sender: UIButton) {
        
        selectedPickerType = .province
        showAndHideCommonPicker(isShow: true)
        takeaSurveyButtonOutlet.isHidden = true
        
    }
    
    
    @IBAction func takeaSurveyTapped(_ sender: UIButton) {
        
//        singupFormFieldDelegate?.singupField(name: txtName.text!, mobile: txtPhone.text!, email: txtEmail.text!, gender: txtGender.text!, country: txtCountry.text!, province: txtProvince.text!)

        let vc = storyboard?.instantiateViewController(withIdentifier: "SurveyQuestionViewController") as! SurveyQuestionViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch selectedPickerType {
        case .gender:
            txtGender.text = arrGender[row]
        case .country:
            txtCountry.text = arrCountry[row]
        case .province:
            txtProvince.text = arrProvince[row]
        }
    }
}


extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        switch selectedPickerType {
            
        case .gender :
            return arrGender.count
        case .country:
            return arrCountry.count
        case .province:
            return arrProvince.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch selectedPickerType {
        case .gender:
            return arrGender[row]
        case .country:
            return arrCountry[row]
        case .province:
            return arrProvince[row]
        }
        
    }
}
