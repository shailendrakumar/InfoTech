//
//  ViewController.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21.
//

import UIKit

class ViewController: BaseVC {

    //MARK:- PROPERTIES
    @IBOutlet weak var movieTableView : UITableView!
    @IBOutlet weak var searchBar      : UITextField!
    var refrashControl : UIRefreshControl!
    var objHomeVM                     = HomeVM()

    //MARK:-  VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objHomeVM.setupUI(self.movieTableView, self.searchBar)
        self.objHomeVM.errorMessage = { (errorMsg) in
            self.ShowTheAlert(msg: errorMsg)
        }
        self.objHomeVM.selectCell = { (imdbID) in
            self.MoveToDetails(imdbID: imdbID)
        }
      //  self.objHomeVM.fetchFromDataBase()
    }
}
