//
//  DirectorCell.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21.
//

import UIKit

class DirectorCell: UITableViewCell {
    //MARK:- PROPERTIES
    @IBOutlet weak var directorLabel : UILabel!
    @IBOutlet weak var writersLabel  : UILabel!
    @IBOutlet weak var actorsLabel   : UILabel!
    @IBOutlet weak var bgView        : UIView!
   
    //MARK:- awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 10
    }
    //MARK:- Configure UITableView Cell
    public func configureCell(moveDetail:MoveDetailCodeable){
        self.directorLabel.text = moveDetail.director
        self.writersLabel.text  = moveDetail.writer
        self.actorsLabel.text   = moveDetail.actors
    }
}
