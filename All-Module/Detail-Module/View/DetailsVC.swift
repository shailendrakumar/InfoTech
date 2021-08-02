//
//  DetailsVC.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21.
//

import UIKit

class DetailsVC: BaseVC {

    //MARK:- PROPERTIES
    @IBOutlet weak var movieDetailTableView : UITableView!
    var objDetailsVM                  = DetailsVM()
 
    //MARK:-  VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objDetailsVM.setupUI(self.movieDetailTableView)
        self.objDetailsVM.movieDetailsWebAPICall()
        self.objDetailsVM.errorMessage = { (errorMsg) in
            self.ShowTheAlert(msg: errorMsg)
        }
    }
}

extension DetailsVC{
    //MARK:-  TAP ON PAYMENT AND BACK BUTTON
    @IBAction func BtnAction(sender:UIButton){
        switch sender.tag {
            case 0: self.POP()
            default: break
        }
    }
}
