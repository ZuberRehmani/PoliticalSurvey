//
//  SurveyListViewController.swift
//  PoliticalSurvey
//
//  Created by mac on 31/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SurveyListViewController: UIViewController {
    
    @IBOutlet weak var tblSurvey: UITableView!
    var arrSurveyModel = [SurveyModel]()

    let objSurveyModel1 = SurveyModel(surveyNumber: 1, question: "Who is your favourite Polition", date: "15-12-2015", country: "India", province: "MP")
    let objSurveyModel2 = SurveyModel(surveyNumber: 2, question: "Who is your favourite Party", date: "16-12-2015", country: "London", province: "AP")
    let objSurveyModel3 = SurveyModel(surveyNumber: 3, question: "Who is your favourite Polition", date: "17-12-2015", country: "India", province: "GJ")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrSurveyModel.append(objSurveyModel1)
        arrSurveyModel.append(objSurveyModel2)
        arrSurveyModel.append(objSurveyModel3)
      
    }
    
}

extension SurveyListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSurveyModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        
        cell.lblSurveyNumber.text = "Survey No." + "\(arrSurveyModel[indexPath.row].surveyNumber)"
        cell.lblQuestion.text = "Question :" + arrSurveyModel[indexPath.row].question
        cell.lblDate.text = "Date :" + arrSurveyModel[indexPath.row].date
        cell.lblCountry.text = "Country :" + arrSurveyModel[indexPath.row].country
        cell.lblProvince.text = "Province :" + arrSurveyModel[indexPath.row].province
        cell.selectionStyle = UITableViewCellSelectionStyle.gray
       
        return cell
    }
    
    
}
