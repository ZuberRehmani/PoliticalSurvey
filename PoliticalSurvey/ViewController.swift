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
    
    @IBOutlet weak var viewTakeASurvey: UIView!
   
    
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
   // var arrCountry = ["India","London"]
    var arrProvince = ["Madhya Pardesh","Uttar Pardesh","Aandhra Pardesh"]
    
    var arrCountryModel = [CountryModel]()
    
    var countryModelObject1 = CountryModel(countryID: "1", countryName: "India")
    var countryModelObject2 = CountryModel(countryID: "2", countryName: "USA")
    var countryModelObject3 = CountryModel(countryID: "3", countryName: "China")
    
    var selectedPickerType: SelectedPicker = .gender

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        arrCountryModel.append(countryModelObject1)
        arrCountryModel.append(countryModelObject2)
        arrCountryModel.append(countryModelObject3)
    }

    @IBAction func selectGenderTapped(_ sender: UIButton) {
       
        selectedPickerType = .gender
        viewTakeASurvey.isHidden = true
      // takeaSurveyButtonOutlet.isHidden = true
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
        viewTakeASurvey.isHidden = false
        //takeaSurveyButtonOutlet.isHidden = false
        
    }
    
    
    @IBAction func commonPickerDoneTapped(_ sender: UIButton) {
        
        showAndHideCommonPicker(isShow: false)
       //viewTakeASurvey.isHidden = false
        //takeaSurveyButtonOutlet.isHidden = false
    
    }
    
    
    
    
    @IBAction func countryButtonTapped(_ sender: UIButton) {
        
        selectedPickerType = .country
        //viewTakeASurvey.isHidden = false
        showAndHideCommonPicker(isShow: true)
       
       // takeaSurveyButtonOutlet.isHidden = true
        
    }
    
    @IBAction func provinceButtonTapped(_ sender: UIButton) {
        
        selectedPickerType = .province
        showAndHideCommonPicker(isShow: true)
       // viewTakeASurvey.isHidden = false
       // takeaSurveyButtonOutlet.isHidden = true
        
    }
    
    
    @IBAction func takeaSurveyTapped(_ sender: UIButton) {
        
//        singupFormFieldDelegate?.singupField(name: txtName.text!, mobile: txtPhone.text!, email: txtEmail.text!, gender: txtGender.text!, country: txtCountry.text!, province: txtProvince.text!)
       let isFill = checkValidation()
        
        if isFill {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SurveyQuestionViewController") as! SurveyQuestionViewController
        navigationController?.pushViewController(vc, animated: true)
        }
        else{
            
            print("Please enter all field")
            
            let alert = UIAlertController(title: "Alert!", message: "Please fill the all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkValidation() -> Bool{
        
        if txtName.text?.isEmpty == true {
            return false
        }
        if txtPhone.text?.isEmpty == true {
            return false
        }
        if txtEmail.text?.isEmpty == true {
            return false
        }
        if  txtGender.text?.isEmpty == true {
            return false
        }
        if txtCountry.text?.isEmpty == true {
            return false
        }
        if txtProvince.text?.isEmpty == true {
            return false
        }
        
        return true
    }
    
}
extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch selectedPickerType {
        case .gender:
            txtGender.text = arrGender[row]
        case .country:
            txtCountry.text = arrCountryModel[row].countryName
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
            return arrCountryModel.count
        case .province:
            return arrProvince.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch selectedPickerType {
        case .gender:
            return arrGender[row]
        case .country:
            return arrCountryModel[row].countryName
        case .province:
            return arrProvince[row]
        }
        
    }
}
