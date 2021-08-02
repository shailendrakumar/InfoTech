//
//  HomeViewModel.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21.
//

import Foundation
import UIKit
import SDWebImage
import CoreData

class HomeVM : NSObject {

    //MARK:- PROPERTIES
    var movieTableView  : UITableView!
    var searchBar       : UITextField!
    var errorMessage    : ((String)->())? = nil
    var selectCell      : ((String)->())? = nil
    var API             = WebService()
    var MoveListData    : MoveListCodeable?
    var moveListArray   = [Search]()
    var page = 1
    var movieName : String = .kEmpty
    var apiType : API_TYPE!
    var refrashControl = UIRefreshControl()
    let appdelegate     = UIApplication.shared.delegate as? AppDelegate
    
    //MARK:- SETUP UI
    func setupUI(_ tableView : UITableView, _ searchBar : UITextField){
        self.apiType = .MovieList
        self.searchBar = searchBar
        self.searchBar.delegate = self
        self.movieTableView = tableView
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        self.movieTableView.register(UINib(nibName: CellName.kMovieCell, bundle: nil), forCellReuseIdentifier: CellName.kMovieCell)
        self.movieTableView.refreshControl?.addTarget(self, action: #selector(HomeVM.refrashAction), for: .valueChanged)
        self.movieTableView.addSubview(self.refrashControl)
        self.API.delegate = self
    }
    @objc func refrashAction(){
        self.refrashControl.beginRefreshing()
        self.apiType = .Refrash
        self.movieName  = "Avengers" //MARK:- Default Movie Name
        self.page = 1
        self.movieWebAPICall()
    }
    //MARK:- WEB SERVICE CALL
    func movieWebAPICall(){
        self.API.APICall(String(format: StringInterpolation.kMovieList, WebServiceName.kMovieAPI,JSON_KEY.kType,EnumType.Movie.rawValue,self.movieName,self.page), .GET , nil)
    }
    @objc func selectMovie(sender:UIButton){
        self.selectCell!(self.moveListArray[sender.tag].imdbID)
    }
}

//===========================================================
//MARK:- UITableViewDelegate,UITableViewDataSource
//===========================================================
extension HomeVM : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moveListArray.count>0 ? self.moveListArray.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellName.kMovieCell, for: indexPath) as! MovieCell
        cell.movieButton.tag = indexPath.row
        if self.moveListArray.count>0 {
            cell.configureCell(search:self.moveListArray[indexPath.item])
            cell.movieButton.addTarget(self, action: #selector(HomeVM.selectMovie(sender:)), for: .touchUpInside)
        }
        return cell
    }
}

//============================
//MARK:- WebServiceDelegate
//============================
extension HomeVM : WebServiceDelegate{
    func getResponse(result: Data) {
        DispatchQueue.main.async {
            Spinner.stop()
            self.refrashControl.endRefreshing()
            self.MoveListData = nil
            guard let moveListData = try? JSONDecoder().decode(MoveListCodeable.self, from: result) else {return}
            if moveListData.response == .kTrue {
                self.MoveListData = moveListData
                if self.apiType == .MovieSearch{
                    self.moveListArray.removeAll()
                    self.DeleteCurrencyListDataBase()
                }
                for i in 0..<(moveListData.search.count){
                    self.moveListArray.append((moveListData.search[i]))
                   // self.InsertValueInDB(moveListData.search[i])
                }
                self.movieTableView.reloadData()
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
//============================
//MARK:- UIScrollViewDelegate
//============================
extension HomeVM : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.apiType != .Refrash{
            if self.MoveListData != nil{
                if self.moveListArray.count > self.MoveListData!.totalResults.count {
                    self.apiType = .MovieList
                    self.page += 1
                    self.movieWebAPICall()
                }
            }
        }
    }
}
//============================
//MARK:- UITextFieldDelegate
//============================
extension HomeVM : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != .kEmpty{
            self.apiType = .MovieSearch
            self.page = 1
            self.movieName = self.movieName.trimmingCharacters(in:.whitespacesAndNewlines)
            self.movieName = textField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            self.movieWebAPICall()
        }
    }
}
extension HomeVM{
    
    //MARK:- Insert Value in Core Data
    public func InsertValueInDB(_ search: Search){
        let manageContext  = appdelegate!.persistentContainer.viewContext
        let movieEntity = NSEntityDescription.entity(forEntityName: "MovieList", in: manageContext)!
        let movieList = NSManagedObject(entity: movieEntity, insertInto:manageContext)
        movieList.setValue("\(search.title)", forKey: "title")
        movieList.setValue("\(search.type)", forKey: "type")
        movieList.setValue("\(search.year)", forKey: "year")
        movieList.setValue("\(search.imdbID)", forKey: "imdbid")
        if search.poster == "N/A"{
            movieList.setValue("", forKey: "poster")
        }else{
            let url:NSURL = NSURL(string : "\(search.poster)")!
            let imageData:NSData = NSData.init(contentsOf: url as URL)!
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            movieList.setValue("\(strBase64)", forKey: "poster")
        }
        do {
            try manageContext.save()
        } catch let error as NSError {
            print("Could not save data.  \(error.debugDescription)")
        }
        self.fetchFromDataBase()
    }
    //MARK:- Fetch Value from Core Data
    func fetchFromDataBase(){
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "MovieList")
        do {
            let manageContext  = appdelegate!.persistentContainer.viewContext
            let result = try manageContext.fetch(fetchRequest)
            if result.count>0{
                for data in result as! [NSManagedObject]{
                    print("data===\(data)")
                }
            }
        } catch  {
            print("Fail Retrive data")
        }
    }
    //MARK:- Delete Value in Core Data
    func DeleteCurrencyListDataBase(){
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "MovieList")
        do {
            let manageContext  = appdelegate!.persistentContainer.viewContext
            let result = try manageContext.fetch(fetchRequest)
            if result.count>0{
                for data in result as! [NSManagedObject]{
                    manageContext.delete(data)
                }
                do {
                    try manageContext.save()
                } catch  {
                    print("error")
                }
            }
        } catch  {
            print("error")
        }
    }
}
