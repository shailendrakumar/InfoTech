//
//  DetailsViewModel.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21.
//

import Foundation
import CoreData
import UIKit

class DetailsVM : NSObject {
    //MARK:- PROPERTIES
    var movieDetailTableView : UITableView!
    var imdbID : String      = .kEmpty
    var errorMessage         : ((String)->())? = nil
    var API                  = WebService()
    var MoveDetailData       : MoveDetailCodeable?
   
    
    //MARK:- SETUP UI
    func setupUI(_ tableView : UITableView){
        self.movieDetailTableView = tableView
        self.movieDetailTableView.delegate = self
        self.movieDetailTableView.dataSource = self
        self.registerTableViewCell()
        self.API.delegate = self
    }
    //MARK:- REGISTER CELL
    public func registerTableViewCell(){
        self.movieDetailTableView.register(UINib(nibName: CellName.kPosterCell, bundle: nil), forCellReuseIdentifier: CellName.kPosterCell)
        self.movieDetailTableView.register(UINib(nibName: CellName.kReviewCell, bundle: nil), forCellReuseIdentifier: CellName.kReviewCell)
        self.movieDetailTableView.register(UINib(nibName: CellName.kDirectorCell, bundle: nil), forCellReuseIdentifier: CellName.kDirectorCell)
        self.movieDetailTableView.register(UINib(nibName: CellName.kCountryCell, bundle: nil), forCellReuseIdentifier: CellName.kCountryCell)
    }
    //MARK:- WEB SERVICE CALL
    func movieDetailsWebAPICall(){
        Spinner.start()
        self.API.APICall(String(format:StringInterpolation.kMovieDetail, WebServiceName.kMovieAPI,self.imdbID) , .GET , nil)
    }
}

//===========================================================
//MARK:- UITableViewDelegate,UITableViewDataSource
//===========================================================
extension DetailsVM : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.MoveDetailData != nil ? 4 :0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.kPosterCell, for: indexPath) as! PosterCell
            if self.MoveDetailData != nil{
                cell.configureCell(moveDetail:self.MoveDetailData!)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.kReviewCell, for: indexPath) as! ReviewCell
            if self.MoveDetailData != nil{
                cell.configureCell(moveDetail:self.MoveDetailData!)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.kDirectorCell, for: indexPath) as! DirectorCell
            if self.MoveDetailData != nil{
                cell.configureCell(moveDetail:self.MoveDetailData!)
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellName.kCountryCell, for: indexPath) as! CountryCell
            if self.MoveDetailData != nil{
                cell.configureCell(moveDetail:self.MoveDetailData!)
            }
            return cell
        default:break
        }
        return UITableViewCell()
    }
}

//============================
//MARK:- WebServiceDelegate
//============================
extension DetailsVM : WebServiceDelegate{
    
    func getResponse(result: Data) {
        DispatchQueue.main.async {
            Spinner.stop()
            guard let moveDetailData = try? JSONDecoder().decode(MoveDetailCodeable.self, from: result) else {return}
            if moveDetailData.response == .kTrue {
                self.MoveDetailData = moveDetailData
                self.movieDetailTableView.reloadData()
            }
            else{
                self.errorMessage!((.kSomethingWorng) as String)
            }
        }
    }
    func getErrorResponse(error: NSString) {
        DispatchQueue.main.async {
            Spinner.stop()
            self.errorMessage!((error) as String)
        }
    }
}
