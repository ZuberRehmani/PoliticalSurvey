//
//  ViewController.swift
//  PoliticalSurvey
//
//  Created by mac on 27/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import CoreData


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
    @IBOutlet weak var txtProvience: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewPicker: UIView!
    @IBOutlet weak var commonPicker: UIPickerView!
    @IBOutlet weak var takeaSurveyButtonOutlet: UIButton!
    
    
    var arrGender = ["Male","Female"]
  
    var arrCountryModel = [Country]()
    var arrProvienceModel = [Provience]()
    
    var selectedPickerType: SelectedPicker = .gender
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedGender:String?
    var selectedCountryName:String?
    var selectedProvince:String?
    var selectedCountryId:Int16 = Int16(101)
    var selectedProvinceId: Int?

    var whichDataNotEntered: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getAllCountries()
    }
    
    func getAllCountries(){
        
        let url = URL(string: "http://applligent.com/project/survey/api/countries")
        
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { (responseData, urlResponse, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }

             let decoder = JSONDecoder()
            
            do {
                if let data = responseData {
                let countries = try decoder.decode(CountryModel.self, from: data)
                   // print("Countries are ",countries)
                    self.arrCountryModel = countries.countries!
                }
                
            }
            catch{
                print("Enable to decode",error.localizedDescription)
            }
        }
        task.resume()
        }
    
    func getProvince(){
        
        let url = URL(string: "http://applligent.com/project/survey/api/provience/\(selectedCountryId)")
        //print(url)
        
        let request = URLRequest(url: url!)
    
        let task = URLSession.shared.dataTask(with: request) { (responseData, urlResponse, error) in
            
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            let decoder = JSONDecoder()
            
            do{
                if let data = responseData {
                    
                    let proviences = try decoder.decode(ProvienceModel.self, from: data)
                    self.arrProvienceModel = proviences.provience!
                
                DispatchQueue.main.async {
                    self.commonPicker.reloadAllComponents()
                             }
                  }
            }
            catch{
                print("unable to decode")
            }
        }
        task.resume()
        
    }
    
    
    @IBAction func selectGenderTapped(_ sender: UIButton) {
       
        selectedPickerType = .gender
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
    }
    
    
    @IBAction func commonPickerDoneTapped(_ sender: UIButton) {
        showAndHideCommonPicker(isShow: false)
    }
    
    
    
    
    @IBAction func countryButtonTapped(_ sender: UIButton) {
        commonPicker.reloadAllComponents()
        selectedPickerType = .country
        showAndHideCommonPicker(isShow: true)
    }
    
    @IBAction func provinceButtonTapped(_ sender: UIButton) {
        getProvince()
        commonPicker.reloadAllComponents()
        selectedPickerType = .province
        showAndHideCommonPicker(isShow: true)
   }
    
    func postLoginData(){
        let gender:Int?
        guard let url = URL(string: "http://applligent.com/project/survey/api/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if txtGender.text == "Male" {
            gender = 1
        }
        else{
            gender = 2
        }
        let countryId = Int(selectedCountryId)
        let tokenId = "1234Sample1234"
//        let deviceID = UIDevice.current.identifierForVendor!.uuidString
//        print(deviceID)
        let newUser = RegistrationRequestModel(fullName: txtName.text!, emailAddress: txtEmail.text!, contactNo: txtPhone.text!, gender: gender!, countryId: countryId, provienceId: selectedProvinceId!, deviceToken: tokenId)
        
            do {
            let jsonBody = try JSONEncoder().encode(newUser)
            request.httpBody = jsonBody
            //print(jsonBody)
            let jsonString = String(data: jsonBody, encoding: .utf8)
            //print(jsonString!)
            }
        catch{
            print(error.localizedDescription)
            }
        let task = URLSession.shared.dataTask(with: request) { (responseData,urlResponse,error)  in
            guard let data = responseData else { return }
            print(data)
            
            do {
                let sentUser = try JSONDecoder().decode(UserModel.self, from: data)
                print(sentUser.message!)
                
//                let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
//                print(jsonData!)
                DispatchQueue.main.async {
                    
                }
            }
            catch{
                print(error)
            }
        }
       task.resume()
    }
    
    @IBAction func takeaSurveyTapped(_ sender: UIButton) {
        
        
       let isFill = checkValidation()
       if isFill {
        //saveDataInDatabase()
        postLoginData()
        let vc = storyboard?.instantiateViewController(withIdentifier: "SurveyQuestionViewController") as! SurveyQuestionViewController
        navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Alert!", message: "Please enter your , \(whichDataNotEntered)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkValidation() -> Bool{
        
        if txtName.text?.isEmpty == true {
            whichDataNotEntered = "Name"
            return false
        }
        if txtPhone.text?.isEmpty == true {
            whichDataNotEntered = "Contact No"
            return false
        }
        if txtEmail.text?.isEmpty == true {
            whichDataNotEntered = "Email Address"
            return false
        }
        if  txtGender.text?.isEmpty == true {
            whichDataNotEntered = "Gender"
            return false
        }
        if txtCountry.text?.isEmpty == true {
            whichDataNotEntered = "Country"
            return false
        }
        if txtProvience.text?.isEmpty == true {
            whichDataNotEntered = "Provience"
            return false
        }
        
        return true
    }
    
    func saveDataInDatabase(){
        
        let context = appDelegate.persistentContainer.viewContext
//        
//        let userModelObject = User(context: context)
//        userModelObject.name = txtName.text!
//        userModelObject.phone = txtPhone.text!
//        userModelObject.email = txtEmail.text!
//        userModelObject.gender = selectedGender
//        userModelObject.countryName = selectedCountryName
//        //userModelObject.countryId = selectedCountryId!
//        userModelObject.province = selectedProvince
        
        
        do {
            try context.save()
            print("Data saved succesfully")
        }
        catch let error {
            print("An error accured saving user data context \(error.localizedDescription)")
        }
        
    }
    
}
extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch selectedPickerType {
        case .gender:
            txtGender.text = arrGender[row]
            selectedGender = arrGender[row]
        case .country:
            txtCountry.text = arrCountryModel[row].countryName
            selectedCountryName = arrCountryModel[row].countryName
            selectedCountryId = Int16(arrCountryModel[row].countryId!)!
        case .province:
            
            txtProvience.text = arrProvienceModel[row].provienceName
            selectedProvince = arrProvienceModel[row].provienceName
            selectedProvinceId = Int(arrProvienceModel[row].provienceId!)
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
            return arrProvienceModel.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch selectedPickerType {
        case .gender:
            return arrGender[row]
        case .country:
            return arrCountryModel[row].countryName
             //return ""
            
        case .province:
            return arrProvienceModel[row].provienceName
        }
        
    }
}
