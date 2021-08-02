//
//  PosterCell.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21.
//

import UIKit

class PosterCell: UITableViewCell {
    //MARK:- PROPERTIES
    @IBOutlet weak var movieImageView : UIImageView!
    @IBOutlet weak var categoryBgView : UIView!
    @IBOutlet weak var movieNameLabel : UILabel!
    @IBOutlet weak var yearLabel      : UILabel!
    @IBOutlet weak var synopsisLabel  : UILabel!
    
    //MARK:- awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categoryBgView.layer.cornerRadius = 10
    }
    //MARK:- Configure UITableView Cell
    public func configureCell(moveDetail:MoveDetailCodeable){
        self.movieImageView.sd_setImage(with: URL(string: moveDetail.poster), placeholderImage: UIImage(named: ImageName.NoDetailMovie.rawValue))
        self.movieNameLabel.text = moveDetail.title
        self.yearLabel.text      = .kYear + moveDetail.year
        self.synopsisLabel.text  = moveDetail.plot
    }
}
