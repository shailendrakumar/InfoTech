//
//  ReviewCell.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21.
//

import UIKit

class ReviewCell: UITableViewCell {
    //MARK:- PROPERTIES
    @IBOutlet weak var categoryLabel   : UILabel!
    @IBOutlet weak var popularityLabel : UILabel!
    @IBOutlet weak var reviewLabel     : UILabel!
    @IBOutlet weak var scoreLabel      : UILabel!
    @IBOutlet weak var timeLabel       : UILabel!
    @IBOutlet weak var rateLabel       : UILabel!
    @IBOutlet weak var categoryBgView  : UIView!
    
    //MARK:- awakeFromNib
    override func awakeFromNib() {
        self.categoryBgView.layer.cornerRadius = 10
        super.awakeFromNib()
    }
    //MARK:- Configure UITableView Cell
    public func configureCell(moveDetail:MoveDetailCodeable){
        self.categoryLabel.text   = moveDetail.type
        self.popularityLabel.text = moveDetail.imdbVotes
        self.reviewLabel.text     = moveDetail.rated
        self.scoreLabel.text      = moveDetail.metascore
        self.timeLabel.text       = moveDetail.runtime
        self.rateLabel.text       = moveDetail.imdbRating
    }
}
