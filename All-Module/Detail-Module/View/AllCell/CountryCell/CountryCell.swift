//
//  CountryCell.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21.
//

import UIKit

class CountryCell: UITableViewCell {
    //MARK:- PROPERTIES
    @IBOutlet weak var releasedLabel   : UILabel!
    @IBOutlet weak var genreLabel      : UILabel!
    @IBOutlet weak var languageLabel   : UILabel!
    @IBOutlet weak var countryLabel    : UILabel!
    @IBOutlet weak var awardsLabel     : UILabel!
    @IBOutlet weak var dvdLabel        : UILabel!
    @IBOutlet weak var boxOfficeLabel  : UILabel!
    @IBOutlet weak var productionLabel : UILabel!
    @IBOutlet weak var bgView          : UIView!
    
    //MARK:- awakeFromNib
    override func awakeFromNib() {
        self.bgView.layer.cornerRadius = 10
        super.awakeFromNib()
    }
    //MARK:- Configure UITableView Cell
    public func configureCell(moveDetail:MoveDetailCodeable){
        self.releasedLabel.text   = moveDetail.released
        self.genreLabel.text      = moveDetail.genre
        self.languageLabel.text   = moveDetail.language
        self.countryLabel.text    = moveDetail.country
        self.awardsLabel.text     = moveDetail.awards
        self.dvdLabel.text        = moveDetail.dvd
        self.boxOfficeLabel.text  = moveDetail.boxOffice
        self.productionLabel.text = moveDetail.production
    }
}
